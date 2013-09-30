class FacebookPost < ActiveRecord::Base
  attr_accessible :lat, :lng, :location, :text
  default_scope order('created_at DESC')

  def map_marker_text
    self.text.html_safe
  end

end
