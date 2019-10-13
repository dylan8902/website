class AddIndexesToAnalytics < ActiveRecord::Migration[4.2]
  def change
    add_index :analytics, :created_at
    add_index :analytics, :referer
  end
end
