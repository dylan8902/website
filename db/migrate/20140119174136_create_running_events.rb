class CreateRunningEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :running_events do |t|
      t.string  :name
      t.string  :location
      t.decimal :lat, :precision => 10, :scale => 7
      t.decimal :lng, :precision => 10, :scale => 7
      t.integer :finish_time
      t.boolean :training
      t.timestamps
    end
  end
end
