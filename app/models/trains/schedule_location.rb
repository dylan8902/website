class Trains::ScheduleLocation < ActiveRecord::Base
  self.table_name = "train_schedule_locations"

  def location
    Trains::Location.find_by_tiploc(self.tiploc_code)
  end

end