class AddKmlToRunningEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :running_events, :kml, :text
  end
end
