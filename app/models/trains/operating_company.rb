require 'will_paginate/array'
class Trains::OperatingCompany < ActiveRecord::Base
  self.table_name = "train_operating_companies"

  def routes(page = nil)
    routes = Array.new
    schedules = Trains::Schedule.where("atoc_code = ? AND (stp_indicator = ? OR stp_indicator = ?)", self.atoc, "P", "N").limit(1)
    schedules.each do |schedule|
      hash = { origin: schedule.origin, destination: schedule.destination, schedule: schedule.train_uid }
      routes << hash unless routes.include? hash
    end
    return routes
  end

end