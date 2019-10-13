class CreateTrainPowerTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :train_power_types do |t|
      t.string :code
      t.string :name
    end
    add_index :train_power_types, :code
  end
end
