class CreateQuizUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :quiz_users do |t|
      t.text :nickname
      t.integer :points

      t.timestamps
    end
  end
end
