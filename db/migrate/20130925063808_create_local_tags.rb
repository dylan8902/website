class CreateLocalTags < ActiveRecord::Migration[4.2]
  def change
    create_table :local_tags do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
