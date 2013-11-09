class CreateBusStops < ActiveRecord::Migration
  def change
    create_table :bus_stops do |t|
      t.string :atco_code
      t.string :naptan_code
      t.string :common_name
      t.string :short_common_name
      t.string :landmark
      t.string :street
      t.string :crossing
      t.string :indicator
      t.string :bearing
      t.string :nptg_locality_code
      t.string :locality_name
      t.string :parent_locality_name
      t.string :grand_parent_locality_name
      t.string :town
      t.string :suburb
      t.string :lat
      t.string :lng
      t.string :stop_type
      t.string :bus_stop_type
      t.string :timing_status
      t.string :default_wait_time
      t.string :administrative_area_code
      t.timestamps
    end
    add_index :bus_stops, :naptan_code
  end
end
