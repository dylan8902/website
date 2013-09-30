class BlogTag < ActiveRecord::Base
  attr_accessible :tag
  validates :tag, :presence => true
  belongs_to :blog_post
  
  def to_param
    URI::escape(tag)
  end
  
  def blog_posts
    ids = BlogTag.select(:blog_post_id).where(:tag => tag)
    BlogPost.find_all_by_id(ids)
  end
  
end
