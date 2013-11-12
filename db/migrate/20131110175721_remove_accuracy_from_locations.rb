class RemoveAccuracyFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :accuracy
    remove_column :locations, :text
  end
end
