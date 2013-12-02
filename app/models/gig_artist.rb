class GigArtist < ActiveRecord::Base
  belongs_to :gig


  def image_url
    if self.mbid
      return "https://www.bbc.co.uk/music/images/artists/542x305/#{self.mbid}.jpg"
    else
      return "/images/no_mbzid_544x306.png"
    end
  end
  
  
  def link
    if self.mbid
      return  "/music/artists/" + self.mbid
    else
      return  "/music/artists?q=" + URI::escape(self.name)
    end
  end


end