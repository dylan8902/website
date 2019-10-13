class AddGeoToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :lat, :float
    add_column :photos, :lng, :float
    add_column :photos, :description, :text
  end
end
