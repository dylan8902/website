class AddUniqueIndexToDuoLeaderboards < ActiveRecord::Migration[7.0]
  def change
    add_index :duo_leaderboards, :url, unique: true
  end
end
