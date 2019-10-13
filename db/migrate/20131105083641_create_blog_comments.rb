class CreateBlogComments < ActiveRecord::Migration[4.2]
  def change
    create_table :blog_comments do |t|
      t.integer :user_id
      t.integer :blog_post_id
      t.string :name
      t.string :email
      t.text :comment

      t.timestamps
    end
  end
end
