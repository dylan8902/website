class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title, :null => false
      t.text :text, :null => false

      t.timestamps
    end
  end
end
