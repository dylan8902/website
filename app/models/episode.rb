class Episode < ActiveRecord::Base
  attr_accessible :pid, :title, :description
  default_scope order('created_at DESC')
  self.per_page = 15
  
  def to_param
    self.pid
  end
  
  def image
    "https://www.bbc.co.uk/iplayer/images/episode/#{self.pid}_640_360.jpg"
  end
  
end
