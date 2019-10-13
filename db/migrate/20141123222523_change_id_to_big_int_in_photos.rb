class ChangeIdToBigIntInPhotos < ActiveRecord::Migration[4.2]
  def change
    change_column :photos, :id, :integer, :limit => 8
  end
end
