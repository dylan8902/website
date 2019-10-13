class ChangeLocations < ActiveRecord::Migration[4.2]
  def change
    change_column :locations, :lat, :integer
    change_column :locations, :lng, :integer
  end
end
