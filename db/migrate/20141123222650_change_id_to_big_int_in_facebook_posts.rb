class ChangeIdToBigIntInFacebookPosts < ActiveRecord::Migration[4.2]
  def change
    change_column :facebook_posts, :id, :integer, :limit => 8
  end
end
