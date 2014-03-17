class Trains::Category < ActiveRecord::Base
  self.table_name = "train_categories"


  def routes page
    routes = Array.new
    schedules = Trains::Schedule.where("train_category = ? AND (stp_indicator = ? OR stp_indicator = ?)", self.code, "P", "N").paginate(page)
    schedules.each do |schedule|
      hash = { origin: schedule.origin, destination: schedule.destination, schedule: schedule.train_uid }
      routes << hash unless routes.include? hash
    end
    return routes
  end

end