class ChangeLocationsLatLng < ActiveRecord::Migration
  def change
    rename_column :locations, :lat, :latE7
    rename_column :locations, :lng, :lngE7
  end
end
