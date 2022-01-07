class GigArtist < ApplicationRecord
  belongs_to :gig


  def image_url
    "/images/no_mbzid_544x306.png"
  end


  def link
    if self.mbid
      return  "/music/artists/" + self.mbid
    else
      return  "/music/artists?q=" + URI::escape(self.name)
    end
  end


end
