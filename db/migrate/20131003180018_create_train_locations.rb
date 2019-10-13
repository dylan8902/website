class CreateTrainLocations < ActiveRecord::Migration[4.2]
  def change
    create_table :train_locations do |t|
      t.string :name
      t.string :crs
      t.string :nlc
      t.string :tiploc
      t.string :stanox
      t.float :lat
      t.float :lng
      t.boolean :station
    end
    add_index :train_locations, :crs
    add_index :train_locations, :tiploc
    add_index :train_locations, :stanox
  end
end
