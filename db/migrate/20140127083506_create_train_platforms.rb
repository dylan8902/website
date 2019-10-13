class CreateTrainPlatforms < ActiveRecord::Migration[4.2]
  def change
    create_table :train_platforms do |t|
      t.string :name
      t.string :tiploc
      t.integer :length
      t.timestamps
    end
    add_index :train_platforms, :tiploc
  end
end
