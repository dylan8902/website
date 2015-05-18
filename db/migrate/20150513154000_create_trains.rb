class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.string :origin
      t.string :destination
      t.string :operator
      t.decimal :lat, :precision => 10, :scale => 7
      t.decimal :lng, :precision => 10, :scale => 7
      t.timestamps
    end
  end
end
