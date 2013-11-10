class ChangeAnalyticsUriToText < ActiveRecord::Migration
  def change
    change_column :analytics, :uri, :text
  end
end
