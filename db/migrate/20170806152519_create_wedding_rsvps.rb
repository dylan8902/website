class CreateWeddingRsvps < ActiveRecord::Migration[5.0]
  def change
    create_table :wedding_rsvps do |t|
      t.string :name
      t.boolean :rsvp
      t.text :notes

      t.timestamps
    end
  end
end
