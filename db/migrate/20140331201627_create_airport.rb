class CreateAirport < ActiveRecord::Migration[4.2]
  def change
    create_table :airports do |t|
      t.string :name
      t.string :city
      t.string :country
      t.string :iata
      t.string :icao
      t.decimal :lat, :precision => 10, :scale => 7
      t.decimal :lng, :precision => 10, :scale => 7
      t.integer :altitude
      t.integer :timezone_offset
      t.string :dst
    end
  end
end
