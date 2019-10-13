class CreateDjEvents < ActiveRecord::Migration[4.2]
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
