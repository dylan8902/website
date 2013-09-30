class CreateDrops < ActiveRecord::Migration
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
