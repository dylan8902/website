class CreateTrainSchedules < ActiveRecord::Migration
  def change
    create_table :train_schedules do |t|
      t.date :schedule_start_date
      t.date :schedule_end_date
      t.string :schedule_days_runs
      t.integer :bank_holiday_running
      t.string :stp_indicator
      t.string :train_uid
      t.string :applicable_timetable
      t.string :atoc_code
      t.string :signalling_id
      t.string :train_category
      t.string :headcode
      t.string :course_indicator
      t.string :train_service_code
      t.string :business_sector
      t.string :power_type
      t.string :timing_load
      t.string :speed
      t.string :operating_characteristics
      t.string :train_class
      t.string :sleepers
      t.string :reservations
      t.string :connection_indicator
      t.string :catering_code
      t.string :service_branding
      t.string :train_status
      t.string :ransaction_type
    end
    add_index :train_schedules, :train_uid
    add_index :train_schedules, :schedule_start_date
    add_index :train_schedules, :schedule_end_date
    add_index :train_schedules, :headcode
  end
end
