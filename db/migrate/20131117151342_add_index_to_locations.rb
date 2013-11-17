class AddIndexToLocations < ActiveRecord::Migration
  def change
    add_index :locations, :lat
    add_index :locations, :lng
  end
end
