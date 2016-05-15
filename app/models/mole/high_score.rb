class Mole::HighScore < ApplicationRecord
  self.table_name = 'mole_high_scores'
  validates :name, presence: true
  default_scope { order('score DESC') }

  def image
    url = "https://secure.gravatar.com/avatar/3184f60ba2d0eca8d4a55a8f2bbedac9.jpg?s=60&d=identicon" if self.facebook_id.nil?
    url = "https://graph.facebook.com/#{self.facebook_id}/picture?size=square" if self.facebook_id
    return "<img src=\"#{url}\" class=\"thumbnail\">".html_safe
  end

end
