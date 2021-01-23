class CreateOauthClients < ActiveRecord::Migration[5.0]
  def change
    create_table :oauth_clients do |t|
      t.text :name
      t.text :client_id
      t.text :client_secret
      t.text :access_token
      t.text :refresh_token
      t.text :expires_at
      t.text :scope
      t.text :response_type
      t.text :redirect_uri

      t.timestamps
    end
  end
end
