class AddDistanceToRunningEvents < ActiveRecord::Migration
  def change
    add_column :running_events, :distance, :integer
  end
end
