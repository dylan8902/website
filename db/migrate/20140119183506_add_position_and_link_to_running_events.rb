class AddPositionAndLinkToRunningEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :running_events, :position, :string
    add_column :running_events, :link, :string
  end
end
