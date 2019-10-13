class AddDistanceToTrainJourneyLegs < ActiveRecord::Migration[4.2]
  def change
    add_column :train_journey_legs, :distance, :integer
  end
end
