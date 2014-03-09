class Trains::Journey < ActiveRecord::Base
  self.table_name = 'train_journeys'

  belongs_to :user


  def legs
    Trains::JourneyLeg.where(journey_id: self.id).order(:id)
  end


  def origin
    return nil if self.legs.first.nil?
    return self.legs.first.origin
  end


  def destination
    return nil if self.legs.last.nil?
    return self.legs.last.destination
  end

 
  def departure_time
    return nil if self.legs.first.nil?
    return self.legs.first.departure_time
  end


  def arrival_time
    return nil if self.legs.first.nil?
    return self.legs.last.arrival_time
  end


  def to_s
    origin = self.origin || "Unknown"
    destination = self.destination || "Unknown"
    return "#{origin} to #{destination}"
  end

  def google_map_image
    return nil if self.legs.count == 0
    src = "https://maps.googleapis.com/maps/api/staticmap?path=color:0xff0000%7Cweight:7"
    self.legs.each do |leg|
      src << "%7C#{leg.origin.lat},#{leg.origin.lng}" if leg.origin and leg.origin.lat and leg.origin.lng
    end
    src << "%7C#{legs.last.destination.lat},#{legs.last.destination.lng}" if legs.last.destination and legs.last.destination.lat and legs.last.destination.lng
    return src << "&size=320x320&sensor=false".html_safe
  end

end