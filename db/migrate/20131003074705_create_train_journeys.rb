class CreateTrainJourneys < ActiveRecord::Migration[4.2]
  def change
    create_table :train_journeys do |t|
      t.integer :user_id

      t.timestamps
    end
    add_index :train_journeys, :user_id
  end
end
