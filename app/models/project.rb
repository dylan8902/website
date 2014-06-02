class Project < ActiveRecord::Base  
  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true


  def self.hit id
    project = Project.where(id: id).first
    return if project.nil?
    project.hits += 1
    project.save
  end


  def image
    return "/images/project#{self.id}.png"
  end


end