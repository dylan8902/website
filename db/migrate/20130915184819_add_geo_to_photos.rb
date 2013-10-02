class AddGeoToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :lat, :float
    add_column :photos, :lng, :float
    add_column :photos, :description, :text
  end
end
