class Listen < ActiveRecord::Base
  default_scope order('created_at DESC')
  
  def to param
    artist_mbid
  end
  
  def self.update
    url = "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=dylan8902&api_key=" +
          ENV['LASTFM_API_KEY'] + "&format=json&limit=50&page=1"
    response = RestClient.get url
    return nil if response.code != 200
    json = JSON.parse response.body
    puts json
    json['recenttracks']['track'].reverse.each do |track|
      
      Listen.where(created_at: Time.at(track['date']['uts'].to_i), track: track['name']).first_or_create(
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