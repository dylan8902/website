class Track < ApplicationRecord
  self.table_name = "listens"
  default_scope { order('created_at DESC') }


  def image_url
      "/images/no_mbzid_544x306.png"
  end


  def artist_url
    if self.artist_mbid && self.artist_mbid != ""
      return "/music/artists/" + self.artist_mbid
    else
      return "/music/artists?q=" + CGI::escape(self.artist)
    end
  end


  def self.update
    url = "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=dylan8902&api_key=" +
          Rails.application.secrets.lastfm_api_key + "&format=json&limit=50&page=1"
    begin
      response = RestClient.get url
    rescue => e
      logger.info "Listen update problem: " + e.message
      return
    end
    return if response.code != 200
    json = JSON.parse response.body
    json['recenttracks']['track'].reverse.each do |track|
      if track['date']
        Track.where(created_at: Time.at(track['date']['uts'].to_i), track: track['name']).first_or_create(
          artist: track['artist']['#text'],
          artist_mbid: track['artist']['mbid'],
          track_mbid: track['mbid'],
          album: track['album']['#text'],
          album_mbid: track['album']['mbid'],
          image: track['image'][3]['#text'],
          created_at: Time.at(track['date']['uts'].to_i),
          updated_at: Time.now
        )
      end
    end
  end

end
