class ChangeLocations < ActiveRecord::Migration
  def change
    change_column :locations, :lat, :integer
    change_column :locations, :lng, :integer
  end
end
