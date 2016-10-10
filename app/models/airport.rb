class Airport < ApplicationRecord

  #http://openflights.org/data.html#airport

  def to_s
    "#{self.name} (#{self.city}, #{self.country})"
  end

  def map_marker_text
    self.to_s
  end

end
