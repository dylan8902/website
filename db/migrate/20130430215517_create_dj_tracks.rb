class CreateDjTracks < ActiveRecord::Migration[4.2]
  def change
    create_table :dj_tracks do |t|
      t.references :dj_event
      t.string :title
      t.string :artist
      t.string :artist_mbid
      t.timestamps
    end
  end
end
