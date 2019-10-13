class CreateListens < ActiveRecord::Migration[4.2]
  def change
    create_table :listens do |t|
      t.string :artist
      t.string :artist_mbid
      t.string :track
      t.string :track_mbid
      t.string :album
      t.string :album_mbid
      t.string :image

      t.timestamps
    end
  end
end
