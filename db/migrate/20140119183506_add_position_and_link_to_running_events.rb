class AddPositionAndLinkToRunningEvents < ActiveRecord::Migration
  def change
    add_column :running_events, :position, :string
    add_column :running_events, :link, :string
  end
end
