class AddJsonToMonzoTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :monzo_transactions, :json, :text
    add_column :monzo_transactions, :lat, :decimal, :precision => 10, :scale => 7
    add_column :monzo_transactions, :lng, :decimal, :precision => 10, :scale => 7
  end
end
