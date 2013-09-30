class CreateIphoneLocations < ActiveRecord::Migration
  def change
    create_table :iphone_locations do |t|
      t.float :lat
      t.float :lng
      t.integer :accuracy

      t.timestamps
    end
  end
end
