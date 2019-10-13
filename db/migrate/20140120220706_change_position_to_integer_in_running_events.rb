class ChangePositionToIntegerInRunningEvents < ActiveRecord::Migration[4.2]
  def change
    change_column :running_events, :position, :integer
  end
end
