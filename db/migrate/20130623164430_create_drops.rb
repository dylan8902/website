class CreateDrops < ActiveRecord::Migration[4.2]
  def change
    create_table :drops do |t|
      t.string :uri
      t.string :content_type
      t.binary :base64
      t.integer :hits

      t.timestamps
    end
  end
end
