class ChangeIntegerLimitInRunningEvents < ActiveRecord::Migration[5.0]
  def change
    change_column :running_events, :strava_id, :integer, limit: 8
  end
end
