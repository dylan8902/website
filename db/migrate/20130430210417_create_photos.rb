class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :thumbnail
      t.string :original

      t.timestamps
    end
  end
end
