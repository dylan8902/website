class Episode < ActiveRecord::Base
  default_scope order('created_at DESC')
  
  def to_param
    self.pid
  end
  
  def image
    "https://www.bbc.co.uk/iplayer/images/episode/#{self.pid}_640_360.jpg"
  end
  
end
