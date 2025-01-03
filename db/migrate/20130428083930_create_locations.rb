class CreateLocations < ActiveRecord::Migration[4.2]
  def change
    create_table :locations do |t|
      t.float :lat, :null => false
      t.float :lng, :null => false
      t.integer :accuracy, :null => false
      t.string :text, :null => false

      t.timestamps
    end
  end
end
