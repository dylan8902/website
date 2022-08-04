class DjTrack < ApplicationRecord
  default_scope { order('created_at ASC') }
  belongs_to :dj_event


  def image_url
    "/images/no_mbzid_544x306.png"
  end


  def artist_url
    if self.artist_mbid != ""
      return  "/music/artists/" + self.artist_mbid
    else
      return  "/music/artists?q=" + CGI::escape(self.artist)
    end
  end

end
