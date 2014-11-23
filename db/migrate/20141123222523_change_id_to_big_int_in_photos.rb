class ChangeIdToBigIntInPhotos < ActiveRecord::Migration
  def change
    change_column :photos, :id, :integer, :limit => 8
  end
end
