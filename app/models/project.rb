class Project < ActiveRecord::Base
  attr_accessible :description, :hits, :online, :title, :url
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates :url, :presence => true
  
  default_scope order('created_at DESC')


  def hit
    self.hits += 1
    self.save
  end
  
end
