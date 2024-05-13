class RenameRunningEventToStravaEvent < ActiveRecord::Migration[7.0]
  def change
    rename_table :running_events, :strava_event
  end
end
