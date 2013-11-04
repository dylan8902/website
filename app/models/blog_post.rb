class BlogPost < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  default_scope { order('created_at DESC') }
  has_many :blog_tags


  def tag_links
    string = ""
    self.blog_tags.each do |tag|
      string << "<a href=\"/blog/tags/#{tag}\" class=\"tag\">#{tag}</a>\n"
    end
    return string.html_safe
  end

end
