class AddWebauthnIdToUsers < ActiveRecord::Migration[7.0]
  def up
    unless column_exists?(:users, :webauthn_id)
      add_column :users, :webauthn_id, :string, null: true, default: nil
    end
  end

  def down
    remove_column :users, :webauthn_id
  end
end
