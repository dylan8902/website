class AddSportToRunningEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :running_events, :sport, :string, default: "Run"
    add_index :running_events, :sport
  end
end
