class AddStravaIdToRunningEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :running_events, :strava_id, :int
  end
end
