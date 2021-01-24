class ChangeKmlToMediumtext < ActiveRecord::Migration[5.0]
  def change
    change_column :running_events, :kml, :text, limit: 16.megabytes - 1
  end
end
