class CreateAnalytics < ActiveRecord::Migration
  def change
    create_table :analytics do |t|
      t.string :uri
      t.string :ip
      t.string :user_agent
      t.string :referer

      t.timestamps
    end
    add_index :analytics, :ip
    add_index :analytics, :user_agent
  end
end
