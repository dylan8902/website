class CreateDjEvents < ActiveRecord::Migration
  def change
    create_table :dj_events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.string :image
      
      t.timestamps
    end
  end
end
