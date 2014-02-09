class CreateTrainLocationDistances < ActiveRecord::Migration
  def change
    create_table :train_location_distances do |t|
      t.string :origin
      t.string :destination
      t.integer :distance
      t.string :initial_direction
      t.string :final_direction
      t.string :line
      t.timestamps
    end
    add_index :train_location_distances, :origin
    add_index :train_location_distances, :destination
  end
end
