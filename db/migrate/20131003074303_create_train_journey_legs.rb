class CreateTrainJourneyLegs < ActiveRecord::Migration
  def change
    create_table :train_journey_legs do |t|
      t.integer :journey_id
      t.integer :schedule_id
      t.string :departure_crs
      t.datetime :departure_time
      t.integer :departure_delay
      t.string :departure_platform
      t.string :arrival_crs
      t.datetime :arrival_time
      t.integer :arrival_delay
      t.string :arrival_platform
      
      t.timestamps
    end
    add_index :train_journey_legs, :journey_id
    add_index :train_journey_legs, :schedule_id
  end
end
