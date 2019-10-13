class CreateGigArtists < ActiveRecord::Migration[4.2]
  def change
    create_table :gig_artists do |t|
      t.integer :gig_id
      t.string  :name
      t.string  :url
      t.string  :mbid
    end
  end
end
