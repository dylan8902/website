class CreateBlogTags < ActiveRecord::Migration
  def change
    create_table :blog_tags do |t|
      t.string :tag, :null => false
      t.integer :blog_post_id, :null => false
    end
  end
end
