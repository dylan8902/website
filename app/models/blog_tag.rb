class BlogTag < ApplicationRecord
  validates :tag, presence: true
  belongs_to :blog_post


  def to_s
    self.tag
  end


  def to_param
    CGI::escape(tag.tag)
  end


  def blog_posts
    ids = BlogTag.select(:blog_post_id).where(tag: self.tag)
    BlogPost.where(id: ids)
  end


end
