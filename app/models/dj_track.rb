class DjTrack < ActiveRecord::Base
  default_scope order('created_at ASC')
  belongs_to :dj_event


  def image_url
    if self.artist_mbid != ""
      return "https://www.bbc.co.uk/music/images/artists/542x305/#{self.artist_mbid}.jpg"
    else
      return "/images/no_mbzid_544x306.png"
    end
  end


  def artist_url
    if self.artist_mbid != ""
      return  "/music/artists/" + self.artist_mbid
    else
      return  "/music/artists?q=" + URI::escape(self.artist)
    end
  end

end
