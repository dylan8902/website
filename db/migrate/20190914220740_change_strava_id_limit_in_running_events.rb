class ChangeStravaIdLimitInRunningEvents < ActiveRecord::Migration[5.0]
  def change
    change_column :running_events, :strava_id, :string
  end
end
