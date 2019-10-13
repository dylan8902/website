class AddDefaultValueToQuizUsersPoints < ActiveRecord::Migration[4.2]
  def change
    change_column :quiz_users, :points, :integer, :default => 0
  end
end
