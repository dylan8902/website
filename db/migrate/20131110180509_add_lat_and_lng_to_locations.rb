class AddLatAndLngToLocations < ActiveRecord::Migration
  def change
    rename_column :locations, :latE7, :lat
    rename_column :locations, :lngE7, :lng
    change_column :locations, :lat, :float
    change_column :locations, :lng, :float
  end
end