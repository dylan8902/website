class CreateReminders < ActiveRecord::Migration[5.0]
  def change
    create_table :reminders do |t|
      t.string :name
      t.string :time
      t.text :title
      t.text :summary
      t.text :url
      t.text :image
      t.timestamps
    end
  end
end
