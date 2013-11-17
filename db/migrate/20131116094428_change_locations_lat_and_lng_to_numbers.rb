class ChangeLocationsLatAndLngToNumbers < ActiveRecord::Migration
  def change
    change_column :locations, :lat, :decimal, :precision => 10, :scale => 7
    change_column :locations, :lng, :decimal, :precision => 10, :scale => 7
  end
end
