class LocalTag < ApplicationRecord
  belongs_to :user

  def map_marker_text
    "<h4>#{self.title}</h4><p>#{self.description}</p>".html_safe
  end

end
