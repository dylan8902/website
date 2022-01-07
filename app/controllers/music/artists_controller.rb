require 'rest_client'
class Music::ArtistsController < ApplicationController
  include ErrorHelper

  # GET /music/artist
  # GET /music/artist.json
  def index
    Project.hit 14

    @artists = Array.new

    unless params[:q].nil? or params[:q].empty?
      response = RestClient.get "http://musicbrainz.org/ws/2/artist/?fmt=json&limit=7&query=#{URI::escape(params[:q])}"
      if response.code == 200
        json = JSON.parse response.body
        if json['artists']
          @artists = json['artists']
        end
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artists, :callback => params[:callback] }
      format.xml { render xml: @artists }
    end
  end

  # GET /music/artist/1234-567ab-cdef-0012
  # GET /music/artist/1234-567ab-cdef-0012.json
  # GET /music/artist/1234-567ab-cdef-0012.xml
  def show
    Project.hit 14

    unless params[:id] and params[:id].length == 36
      redirect_to music_artists_path + "?q=#{params[:id]}" and return
    end

    @artist = Hash.new

    filename = Rails.root.join("json", "#{params[:id]}.json")
    if File.exists?(filename) and File.mtime(filename) > Time.now - 2.weeks
      @artist = JSON.load filename
    else

      begin
        response = RestClient.get "http://musicbrainz.org/ws/2/artist/#{URI::escape(params[:id])}?fmt=json&inc=aliases+tags"
        if response.code == 200
          @artist = JSON.parse response.body
        end
      rescue
        @artist['artist'] = nil
      end

      # The echonest API has gone
      #begin
      #  response = RestClient.get "http://developer.echonest.com/api/v4/artist/profile?api_key=XACSR313AVJ9RJHE1&id=musicbrainz:artist:#{URI::escape(params[:id])}&format=json&bucket=id:7digital-UK&bucket=images&bucket=songs"
      #  if response.code == 200
      #    json = JSON.parse response.body
      #    @artist['echonest'] = json
      #  end
      #rescue
      #  @artist['echonest'] = nil
      #end

      begin
        seven = @artist['echonest']['response']['artist']['foreign_ids'][0]['foreign_id'].gsub('7digital-UK:artist:','')
      rescue
        seven = nil
      end

      unless seven.nil?
        response = RestClient.get "http://api.7digital.com/1.2/artist/releases?artistid=#{seven}&oauth_consumer_key=7dtahps5452k&country=GB", accept: "application/json"
        if response.code == 200
          json = JSON.parse response.body
          @artist['7digital'] = json
        end
      end

      response = RestClient.get "http://api.songkick.com/api/3.0/artists/mbid:#{URI::escape(params[:id])}/calendar.json?apikey=qF6dIhCO7OeobhpC"
      if response.code == 200
        json = JSON.parse response.body
        if json['resultsPage']
          @artist['songkick'] = json
        end
      end

      File.open(filename, "w") do |f|
        f.write(@artist.to_json)
      end

    end

    if params[:title]
      @og = {
        "og:title" => "#{params[:title]} by #{@artist['name']}",
        "og:type" => "bbc_radio:song",
        "og:url" => request.original_url,
        "og:site_name" => "dyl.anjon.es",
        "fb:app_id" => "149865365127990",
        "bbc_radio:artist" => @artist['name'],
        "bbc_radio:track" => params[:title]
      }
    end

    @artist['listens'] = Track.where("artist_mbid = ?", params[:id]).limit(10)

    @artist['gig_performances'] = GigArtist.where("mbid = ?", params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist, callback: params[:callback] }
      format.xml { render xml: @artist }
    end
  end

end
