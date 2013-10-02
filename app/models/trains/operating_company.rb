class Trains::OperatingCompany < ActiveRecord::Base
  self.table_name = "train_operating_companies"

  def routes
    routes = Array.new
    schedules = Trains::Schedule.where("atoc_code = ? AND (CIF_stp_indicator = ? OR CIF_stp_indicator = ?)", self.atoc, "P", "N")
    schedules.each do |schedule|
      hash = { origin: schedule.origin, destination: schedule.destination, schedule: schedule.uid }
      routes << hash unless routes.include? hash
    end
    return routes
  end

end