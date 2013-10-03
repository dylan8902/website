class Trains::Journey < ActiveRecord::Base
  self.table_name = 'train_journeys'

  has_many :train_journey_legs

end