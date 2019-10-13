class DropTrainTables < ActiveRecord::Migration[4.2]
  def change
    drop_table :train_categories
    drop_table :train_catering
    drop_table :train_classes
    drop_table :train_journey_legs
    drop_table :train_journeys
    drop_table :train_location_distances
    drop_table :train_locations
    drop_table :train_operating_characteristics
    drop_table :train_operating_companies
    drop_table :train_platforms
    drop_table :train_power_types
    drop_table :train_reservations
    drop_table :train_schedule_locations
    drop_table :train_schedules
    drop_table :train_statuses
    drop_table :train_timing_loads
  end
end
