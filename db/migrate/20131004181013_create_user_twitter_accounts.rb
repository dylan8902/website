class CreateUserTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :user_twitter_accounts do |t|
      t.integer :user_id
      t.string :screen_name
      t.string :oauth_token
      t.string :oauth_token_secret
      t.string :access_token
    end
    add_index :user_twitter_accounts, :user_id
    add_index :user_twitter_accounts, :screen_name
  end
end
