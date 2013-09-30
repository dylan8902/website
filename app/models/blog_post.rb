class BlogPost < ActiveRecord::Base
  validates :title, :presence => true
  validates :text, :presence => true
  default_scope order('created_at DESC')
  has_many :blog_tags
end
