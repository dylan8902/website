class CreateDuoLeaderboards < ActiveRecord::Migration[7.0]
  def change
    create_table :duo_leaderboards do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
