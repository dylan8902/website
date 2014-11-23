class ChangeIdToBigIntInFacebookPosts < ActiveRecord::Migration
  def change
    change_column :facebook_posts, :id, :integer, :limit => 8
  end
end
