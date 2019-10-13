class CreateBankTransactions < ActiveRecord::Migration[4.2]
  def change
    create_table :bank_transactions do |t|
      t.string :description, :null => false
      t.float :amount, :null => false

      t.timestamps
    end
  end
end
