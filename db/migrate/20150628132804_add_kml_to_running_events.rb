class AddKmlToRunningEvents < ActiveRecord::Migration
  def change
    add_column :running_events, :kml, :text
  end
end
