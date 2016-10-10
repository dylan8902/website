class WallScore < ApplicationRecord
  default_scope { order('score DESC') }


  def image
    return "<img src=\"https://graph.facebook.com/#{self.facebook_id}/picture\" alt=\"#{self.name}\" style=\"height:50px;width:50px\">".html_safe
  end


  def facebook_link
    return "https://www.facebook.com/profile.php?id=#{self.facebook_id}"
  end


end
