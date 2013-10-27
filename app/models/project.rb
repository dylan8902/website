class Project < ActiveRecord::Base  
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

end