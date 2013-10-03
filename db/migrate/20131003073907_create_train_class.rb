class CreateTrainClass < ActiveRecord::Migration
  def change
    create_table :train_classes do |t|
      t.string :code
      t.string :name
    end
    add_index :train_classes, :code, :unique => true
  end
end
