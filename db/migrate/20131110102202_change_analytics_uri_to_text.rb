class ChangeAnalyticsUriToText < ActiveRecord::Migration[4.2]
  def change
    change_column :analytics, :uri, :text
  end
end
