class CreateTrainStatuses < ActiveRecord::Migration[4.2]
  def change
    create_table :train_statuses do |t|
      t.string :code
      t.string :name
    end
    add_index :train_statuses, :code
  end
end
