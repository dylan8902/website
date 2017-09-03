class CreateMonzoTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :monzo_transactions do |t|
      t.string :monzo_id
      t.text :description
      t.integer :amount
      t.string :currency
      t.text :merchant

      t.timestamps
    end
  end
end
