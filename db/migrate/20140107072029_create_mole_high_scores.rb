class CreateMoleHighScores < ActiveRecord::Migration[4.2]
  def change
    create_table :mole_high_scores do |t|
      t.string :name
      t.integer :facebook_id, limit: 8
      t.integer :score
      t.timestamps
    end
  end
end
