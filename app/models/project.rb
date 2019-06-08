class Project < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true
  default_scope { order('created_at DESC') }

  def self.hit id
    project = Project.where(id: id).first
    return if project.nil?
    project.hits += 1
    project.save
  end


  def image
    return "/images/project#{self.id}.png"
  end


  def link
    if self.online
      return url
    else
      return "/stuff/#{self.id}"
    end
  end


end
