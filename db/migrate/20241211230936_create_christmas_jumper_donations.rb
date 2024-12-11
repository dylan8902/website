class CreateChristmasJumperDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :christmas_jumper_donations do |t|
      t.string :donation_id
      t.string :name

      t.timestamps
    end
  end
end
