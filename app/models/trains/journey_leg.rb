class Trains::JourneyLeg < ActiveRecord::Base
  self.table_name = 'train_journey_legs'
  belongs_to :train_journey
  validates :departure_crs, presence: true
  validates :arrival_crs, presence: true

  def origin
    Trains::Location.find_by_crs(self.departure_crs)
  end


  def destination
    Trains::Location.find_by_crs(self.arrival_crs)
  end

end