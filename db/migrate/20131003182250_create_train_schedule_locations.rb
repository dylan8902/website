class CreateTrainScheduleLocations < ActiveRecord::Migration[4.2]
  def change
    create_table :train_schedule_locations do |t|
      t.integer :schedule_id
      t.string :location_type
      t.string :record_identity
      t.string :tiploc_code
      t.integer :tiploc_instance
      t.string :departure
      t.string :public_departure
      t.string :arrival
      t.string :public_arrival
      t.string :pass
      t.string :platform
      t.string :line
      t.string :engineering_allowance
      t.string :pathing_allowance
      t.string :performance_allowance
    end
    add_index :train_schedule_locations, :schedule_id
    add_index :train_schedule_locations, :tiploc_code
    add_index :train_schedule_locations, :record_identity
  end
end
