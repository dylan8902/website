class CreateMoleDonations < ActiveRecord::Migration[4.2]
  def change
    create_table :mole_donations do |t|
      t.integer :donation_id,   null: false
      t.integer :facebook_id
      t.integer :mole_addon_id
      t.decimal :amount,        precision: 10, scale: 7, null: false
      t.string  :source
      t.string  :environment
      t.timestamps
    end
  end
end
