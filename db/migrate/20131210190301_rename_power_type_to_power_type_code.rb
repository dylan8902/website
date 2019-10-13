class RenamePowerTypeToPowerTypeCode < ActiveRecord::Migration[4.2]
  def change
    rename_column :train_schedules, :power_type, :power_type_code
    rename_column :train_schedules, :train_class, :train_class_code
  end
end
