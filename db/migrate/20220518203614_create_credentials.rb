class CreateCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :credentials do |t|
      t.integer :user_id, foreign_key: true

      t.string :external_id
      t.string :public_key
      t.string :nickname
      t.bigint :sign_count, default: 0, null: false

      t.timestamps
    end
  end
end
