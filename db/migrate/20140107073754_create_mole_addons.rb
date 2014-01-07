class CreateMoleAddons < ActiveRecord::Migration
  def change
    create_table :mole_addons do |t|
      t.string :name,    null: false
      t.string :code,    null: false
      t.decimal :amount, precision: 10, scale: 7, null: false
    end
  end
end
