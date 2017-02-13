class AddDefaultValueToQuizUsersPoints < ActiveRecord::Migration
  def change
    change_column :quiz_users, :points, :integer, :default => 0
  end
end
