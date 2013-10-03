class Trains::JourneyLeg < ActiveRecord::Base
  self.table_name = 'train_journey_legss'

  belongs_to :train_journey

end