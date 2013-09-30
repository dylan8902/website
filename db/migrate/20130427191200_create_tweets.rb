class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.string :location
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
