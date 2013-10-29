class Trains::Journey < ActiveRecord::Base
  self.table_name = 'train_journeys'

  belongs_to :user


  def legs
    Trains::JourneyLeg.where(journey_id: self.id)
  end


  def origin
    return nil if self.legs.first.nil?
    return self.legs.first.origin
  end


  def destination
    return nil if self.legs.last.nil?
    return self.legs.first.destination
  end


  def to_s
    origin = self.origin || "Unknown"
    destination = self.destination || "Unknown"
    return "#{origin} to #{destination}"
  end

end