class BlogPost < ActiveRecord::Base
  attr_accessible :title, :text
  validates :title, :presence => true
  validates :text, :presence => true
  default_scope order('created_at DESC')
  self.per_page = 10
  has_many :blog_tags
end
