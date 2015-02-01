class CreatePringlesPrices < ActiveRecord::Migration
  def change
    create_table :pringles_prices do |t|
      t.string :supermarket
      t.string :offer
      t.float :price
      t.float :price_inc_offer

      t.timestamps
    end
  end
end
