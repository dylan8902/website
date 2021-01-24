class RemoveRedirectUri < ActiveRecord::Migration[5.0]
  def change
    remove_column :oauth_clients, :redirect_uri
  end
end
