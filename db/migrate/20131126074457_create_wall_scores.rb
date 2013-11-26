class CreateWallScores < ActiveRecord::Migration
  def change
    create_table :wall_scores do |t|
      t.integer :facebook_id, limit: 8
      t.string :name
      t.integer :score
      t.timestamps
    end
  end
end
