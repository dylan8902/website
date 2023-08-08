class RenameStravaEventToStravaEvents < ActiveRecord::Migration[7.0]
  def change
    rename_table :strava_event, :strava_events
  end
end
