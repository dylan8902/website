class AddIndexToLocations < ActiveRecord::Migration[4.2]
  def change
    add_index :locations, :lat
    add_index :locations, :lng
  end
end
