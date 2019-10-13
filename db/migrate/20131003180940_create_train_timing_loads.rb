class CreateTrainTimingLoads < ActiveRecord::Migration[4.2]
  def change
    create_table :train_timing_loads do |t|
      t.string :code
      t.string :name
    end
    add_index :train_timing_loads, :code
  end
end
