class ChangeIdToBigIntInTweets < ActiveRecord::Migration[4.2]
  def change
    change_column :tweets, :id, :integer, :limit => 8
  end
end
