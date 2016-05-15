class FacebookPost < ApplicationRecord
  default_scope { order('created_at DESC') }

  def map_marker_text
    self.text
  end

end
