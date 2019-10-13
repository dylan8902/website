class ChangeOriginAndDestinationToIncludeTiploc < ActiveRecord::Migration[4.2]
  def change
    rename_column :train_location_distances, :origin, :origin_tiploc
    rename_column :train_location_distances, :destination, :destination_tiploc
  end
end
