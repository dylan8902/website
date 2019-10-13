class RemoveAccuracyFromLocations < ActiveRecord::Migration[4.2]
  def change
    remove_column :locations, :accuracy
    remove_column :locations, :text
  end
end
