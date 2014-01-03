class AddIndexesToAnalytics < ActiveRecord::Migration
  def change
    add_index :analytics, :created_at
    add_index :analytics, :referer
  end
end
