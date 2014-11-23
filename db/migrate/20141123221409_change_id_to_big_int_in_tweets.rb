class ChangeIdToBigIntInTweets < ActiveRecord::Migration
  def change
    change_column :tweets, :id, :integer, :limit => 8
  end
end
