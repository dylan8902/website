class CreateSolarReadings < ActiveRecord::Migration[5.0]
  def change
    create_table :solar_readings do |t|
      t.date :date
      t.float :kwh

      t.timestamps
    end
  end
end
