class Trains::JourneyLeg < ActiveRecord::Base
  self.table_name = 'train_journey_legs'
  belongs_to :train_journey
  validates :departure_crs, presence: true, length: { is: 3 }
  validates :departure_time, presence: true
  validates :arrival_crs, presence: true, length: { is: 3 }
  validates :arrival_time, presence: true
  before_save :ensure_crs_uppercase


  def origin
    Trains::Location.find_by_crs(self.departure_crs)
  end


  def destination
    Trains::Location.find_by_crs(self.arrival_crs)
  end


  def journey
    Trains::Journey.find(self.journey_id)
  end


  def to_s
    origin = self.origin || "Unknown"
    destination = self.destination || "Unknown"
    return "#{origin} to #{destination}"
  end


  def link
    "/trains/journeys/#{self.journey_id}/legs/#{self.id}"
  end


  private
    def ensure_crs_uppercase
      self.departure_crs = self.departure_crs.upcase
      self.arrival_crs = self.arrival_crs.upcase
    end

end