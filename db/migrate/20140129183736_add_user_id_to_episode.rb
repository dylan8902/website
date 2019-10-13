class AddUserIdToEpisode < ActiveRecord::Migration[4.2]
  def change
    add_column :episodes, :user_id, :integer
    add_index :episodes, :user_id
  end
end
