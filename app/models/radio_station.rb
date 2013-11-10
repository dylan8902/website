require 'rest_client'
class RadioStation
  attr_reader :id, :country, :key, :title, :colour, :show, :recent_tracks
  attr_writer :id, :country, :key, :title, :colour, :show, :recent_tracks


  def initialize station
    @id = station[:id]
    @country = station[:country]
    @key = station[:key]
    @title = station[:title]
    @colour = station[:colour]
    @show = nil
    @recent_tracks = []
    
    self.load_schedule  
    self.load_recent_tracks
    
    puts self.inspect
  end
  
  
  def load_schedule yesterday = ""
    url = "http://www.bbc.co.uk/#{self.id}/programmes/schedules#{self.country}#{yesterday}.json"
    response = RestClient.get url
    return nil if response.code != 200
    
    json = JSON.parse response.body
    json['schedule']['day']['broadcasts'].each do |show|
      if (Time.parse(show['start']) <= Time.now) and (Time.parse(show['end']) > Time.now)
        self.show = show
      end
    end
    
    if self.show.nil?
      load_schedule "/yesterday"
    end
    
  end
  
  
  def load_recent_tracks
    if (self.id == 'radio1') or (self.id == '1xtra') or (self.id == 'radio2') or (self.id == '6music')
      
      url = "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=bbc#{self.id}&api_key=ea5099237517b2b08252aed02e06a3ea&format=json&limit=14";
      
      response = RestClient.get url
      return nil if response.code != 200
      json = JSON.parse response.body
      json['recenttracks']['track'].each do |track|
        self.recent_tracks << Track.new(artist_mbzid: track['artist']['mbid'], artist: track['artist']['#text'], title: track['name'], timestamp: track['date']['uts'].to_i)
      end
    else
      #TODO: Get the canonical episode to get the segments
    end
  end
  
  
  class Track
    attr_reader :title, :artist, :artist_mbzid, :timestamp
    attr_writer :title, :artist, :artist_mbzid, :timestamp


    def initialize track
      @title = track[:title]
      @artist = track[:artist]
      @artist_mbzid = track[:artist_mbzid]
      @timestamp = track[:timestamp]
    end


    def to_s
      "#{artist} - #{title}"
    end


    def image
      if self.artist_mbzid.empty?
        src = "/images/no_mbzid_112x63.png"
      else
        src = "https://www.bbc.co.uk/music/images/artists/112x63/#{self.artist_mbzid}.jpg" 
      end
      return "<img src=\"#{src}\" alt=\"#{self.artist}\">".html_safe 
    end

  end


end