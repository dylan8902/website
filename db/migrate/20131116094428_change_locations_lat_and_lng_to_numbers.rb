class ChangeLocationsLatAndLngToNumbers < ActiveRecord::Migration[4.2]
  def change
    change_column :locations, :lat, :decimal, :precision => 10, :scale => 7
    change_column :locations, :lng, :decimal, :precision => 10, :scale => 7
  end
end
