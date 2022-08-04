class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  has_many :blog_tags
  has_many :blog_comments
  default_scope { order('created_at DESC') }


  def tag_links
    string = ""
    self.blog_tags.each do |tag|
      string << "<a href=\"/blog/tags/#{CGI::escape(tag.tag)}\">#{tag}</a>\n"
    end
    return string.html_safe
  end


  def updated?
    self.created_at != self.updated_at
  end


end
