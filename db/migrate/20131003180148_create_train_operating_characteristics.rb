class CreateTrainOperatingCharacteristics < ActiveRecord::Migration[4.2]
  def change
    create_table :train_operating_characteristics do |t|
      t.string :code
      t.string :name
    end
    add_index :train_operating_characteristics, :code
  end
end
