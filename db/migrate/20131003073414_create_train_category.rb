class CreateTrainCategory < ActiveRecord::Migration[4.2]
  def change
    create_table :train_categories do |t|
      t.string :code
      t.string :name
      t.string :description
    end
    add_index :train_categories, :code, :unique => true
  end
end
