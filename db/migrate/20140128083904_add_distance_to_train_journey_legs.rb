class AddDistanceToTrainJourneyLegs < ActiveRecord::Migration
  def change
    add_column :train_journey_legs, :distance, :integer
  end
end
