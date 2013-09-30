class CreateFacebookPosts < ActiveRecord::Migration
  def change
    create_table :facebook_posts do |t|
      t.string :text
      t.string :location
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
