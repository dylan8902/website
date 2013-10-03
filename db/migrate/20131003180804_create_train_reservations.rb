class CreateTrainReservations < ActiveRecord::Migration
  def change
    create_table :train_reservations do |t|
      t.string :code
      t.string :name
      t.string :symbol
    end
    add_index :train_reservations, :code
  end
end
