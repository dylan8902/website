class CreateTrainCatering < ActiveRecord::Migration
  def change
    create_table :train_catering do |t|
      t.string :code
      t.string :name
    end
    add_index :train_catering, :code, :unique => true
  end
end
