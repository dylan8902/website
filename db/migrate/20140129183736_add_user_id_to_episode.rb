class AddUserIdToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :user_id, :integer
    add_index :episodes, :user_id
  end
end
