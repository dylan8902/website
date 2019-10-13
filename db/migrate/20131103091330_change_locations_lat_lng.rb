class ChangeLocationsLatLng < ActiveRecord::Migration[4.2]
  def change
    rename_column :locations, :lat, :latE7
    rename_column :locations, :lng, :lngE7
  end
end
