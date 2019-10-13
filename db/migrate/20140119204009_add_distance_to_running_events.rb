class AddDistanceToRunningEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :running_events, :distance, :integer
  end
end
