class ChangePositionToIntegerInRunningEvents < ActiveRecord::Migration
  def change
    change_column :running_events, :position, :integer
  end
end
