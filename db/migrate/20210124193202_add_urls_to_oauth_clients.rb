class AddUrlsToOauthClients < ActiveRecord::Migration[5.0]
  def change
    add_column :oauth_clients, :authorise_url, :text
    add_column :oauth_clients, :token_url, :text
  end
end
