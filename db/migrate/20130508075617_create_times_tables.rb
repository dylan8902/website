class CreateTimesTables < ActiveRecord::Migration[4.2]
  def change
    create_table :times_tables do |t|
      t.string :group
      t.string :tables
      t.timestamps
    end
  end
end
