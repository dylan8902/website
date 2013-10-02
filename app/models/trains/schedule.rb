require 'will_paginate/array'
class Trains::Schedule < ActiveRecord::Base
  self.table_name = "train_schedules"

  has_many :schedule_locations
  
  
  def to_param
    self.uid
  end

  def uid
    self.CIF_train_uid
  end


  def headcode
    self.signalling_id
  end


  def service_code
    self.CIF_train_service_code
  end


  def speed
    self.CIF_speed
  end


  def status
    Trains::Status.find_by_code(self.train_status)
  end


  def timing_load
    timing_load = Trains::TimingLoad.find_by_code(self.CIF_timing_load)
    return timing_load unless timing_load.nil?
    return Trains::TimingLoad.new(name: self.CIF_timing_load)
  end


  def catering
    catering = Array.new
    return catering if self.CIF_catering_code.nil?
    self.CIF_catering_code.scan(/./).each do |code|
      catering << Trains::Catering.find_by_code(code)
    end
    return catering
  end


  def train_class
    self.CIF_train_class = "" if self.CIF_train_class.nil?
    Trains::TrainClass.find_by_code(self.CIF_train_class)
  end


  def runs_on_bank_holidays?
    self.CIF_bank_holiday_running
  end


  def power_type
    Trains::PowerType.find_by_code(self.CIF_power_type)
  end


  def category
    Trains::Category.find_by_code(self.CIF_train_category)
  end


  def toc
    Trains::OperatingCompany.find_by_atoc(self.atoc_code)
  end


  def origin
    return Trains::ScheduleLocation.where(:schedule_id => self.id, :record_identity => 'LO').first
  end


  def destination
    return Trains::ScheduleLocation.where(:schedule_id => self.id, :record_identity => 'LT').first
  end


  def days_run
    days = Array.new
    days.push "Monday" if self.schedule_days_runs[0] == "1"
    days.push "Tuesday" if self.schedule_days_runs[1] == "1"
    days.push "Wednesday" if self.schedule_days_runs[2] == "1"
    days.push "Thursday" if self.schedule_days_runs[3] == "1"
    days.push "Friday" if self.schedule_days_runs[4] == "1"
    days.push "Saturday" if self.schedule_days_runs[5] == "1"
    days.push "Sunday" if self.schedule_days_runs[6] == "1"
    return days
  end
  
  
  def self.get_schedules origin, destination, time = Time.now, public = true, buses = false
    #set up the results
    results = Array.new


    #if both destination and origin are set, do this twice and merge results
    unless origin.nil? or destination.nil? then
      origin_schedules = Trains::Schedule.get_schedules origin, nil, time, public, buses
      destination_schedules = Trains::Schedule.get_schedules nil, destination, time, public, buses
      origin_schedules.each do |schedule|
        results.push schedule if destination_schedules.include?(schedule) and schedule.time_at(origin) < schedule.time_at(destination)
      end
      
      return results
    end

    #convert time to string
    time_string = time.strftime("%H%M")

    #if public just use the public field
    if public
      public_string = "public_"
    else
      public_string = ""
    end

    #convert origin or destination to location
    unless origin.nil?
      location = origin
      record_identity = "(record_identity = 'LO' OR record_identity = 'LI')"
      public_string = "#{public_string}departure"
    else
      location = destination
      record_identity = "(record_identity = 'LT' OR record_identity = 'LI')"
      public_string = "#{public_string}arrival"
    end
    
    conditions = "tiploc_code = ? 
      AND (CIF_stp_indicator = 'P' OR CIF_stp_indicator = 'N')
      AND #{record_identity}
      AND #{public_string} IS NOT NULL
      AND schedule_start_date <= ?
      AND schedule_end_date >= ?
      AND SUBSTRING(schedule_days_runs,?,1) = '1' 
      AND #{public_string} >= ?"
  
    conditions << "AND train_status != 'B'" unless buses

    schedules = Trains::Schedule.joins(:schedule_locations)
                         .where(conditions, location.tiploc, time, time, (time.wday + 1), time_string)
                         .order("#{public_string} ASC")
    
    #check for cancellations
    schedules.each do |schedule|
      conditions = "CIF_train_uid = ?
        AND CIF_stp_indicator = 'C'
        AND schedule_start_date <= ?
        AND schedule_end_date >= ?
        AND SUBSTRING(schedule_days_runs,?,1) = '1'"
      cancellation = Trains::Schedule.where(conditions, schedule.CIF_train_uid, time, time, (time.wday + 1))
      #no cancellation then add it to the departures
      results.push schedule if cancellation.empty?
    end
    
    return results
  end
  
  
  def time_at location
    time = nil
    self.schedule_locations.each do |loc|
      time = loc if loc.tiploc_code == location.tiploc
    end
    return nil unless time
    return time.public_departure unless time.public_departure.nil?
    return time.public_arrival unless time.public_arrival.nil?
    return time.departure unless time.departure.nil?
    return time.arrival unless time.arrival.nil?
    return time.pass unless time.pass.nil?
  end
  
  
  def is_bus?
    self.category == "BS"
  end
  
  
  def self.parse_file
    file = "/Users/dylan/Downloads/file.json"
    
    unless File.exist? file
      logger.error "No file to parse found (#{file})"
      return false
    end
    
    File.open(file).each do |line|
      json = JSON.parse(line)
      Trains::Schedule.add json['JsonScheduleV1'] unless json['JsonScheduleV1'].nil?
    end
    
  end


  def self.add schedule
    new_schedule = Trains::Schedule.create(
      :CIF_bank_holiday_running => schedule['CIF_bank_holiday_running'],
      :CIF_stp_indicator => schedule['CIF_stp_indicator'],
      :CIF_train_uid => schedule['CIF_train_uid'],
      :applicable_timetable => schedule['applicable_timetable'],
      :atoc_code => schedule['atoc_code'],
      :schedule_days_runs => schedule['schedule_days_runs'],
      :schedule_end_date => schedule['schedule_end_date'],
      :signalling_id => schedule['schedule_segment']['signalling_id'],
      :CIF_train_category => schedule['schedule_segment']['CIF_train_category'],
      :CIF_headcode => schedule['schedule_segment']['CIF_headcode'],
      :CIF_course_indicator => schedule['schedule_segment']['CIF_course_indicator'],
      :CIF_train_service_code => schedule['schedule_segment']['CIF_train_service_code'],
      :CIF_business_sector => schedule['schedule_segment']['CIF_business_sector'],
      :CIF_power_type => schedule['schedule_segment']['CIF_power_type'],
      :CIF_timing_load => schedule['schedule_segment']['CIF_timing_load'],
      :CIF_speed => schedule['schedule_segment']['CIF_speed'],
      :CIF_operating_characteristics => schedule['schedule_segment']['CIF_operating_characteristics'],
      :CIF_train_class => schedule['schedule_segment']['CIF_train_class'],
      :CIF_sleepers => schedule['schedule_segment']['CIF_sleepers'],
      :CIF_reservations => schedule['schedule_segment']['CIF_reservations'],
      :CIF_connection_indicator => schedule['schedule_segment']['CIF_connection_indicator'],
      :CIF_catering_code => schedule['schedule_segment']['CIF_catering_code'],
      :CIF_service_branding => schedule['schedule_segment']['CIF_service_branding'],
      :schedule_start_date => schedule['schedule_start_date'],
      :train_status => schedule['train_status'],
      :transaction_type => schedule['transaction_type']
    )
    
    unless schedule['schedule_segment']['schedule_location'].nil? then
      schedule['schedule_segment']['schedule_location'].each do |location|
        Trains::ScheduleLocation.create(
          :schedule_id => new_schedule.id,
          :location_type => location['location_type'],
          :record_identity => location['record_identity'],
          :tiploc_code => location['tiploc_code'],
          :tiploc_instance => location['tiploc_instance'],
          :departure => location['departure'],
          :public_departure => location['public_departure'],
          :arrival => location['arrival'],
          :public_arrival => location['public_arrival'],
          :pass => location['pass'],
          :platform => location['platform'],
          :line => location['line'],
          :engineering_allowance => location['engineering_allowance'],
          :pathing_allowance => location['pathing_allowance'],
          :performance_allowance => location['performance_allowance']
        )
      end
    end
  end
  
  
  def google_map_image
    return nil if self.schedule_locations.count == 0
    src = "https://maps.googleapis.com/maps/api/staticmap?path=color:0xff0000%7Cweight:7"
    self.schedule_locations.each do |schedule_location|
      src << "%7C#{schedule_location.location.lat},#{schedule_location.location.lng}" if schedule_location.location and schedule_location.location.lat and schedule_location.location.lng
    end
    return src << "&size=320x320&sensor=false".html_safe
  end
  
  
  def title
    if self.origin and self.destination
      "#{self.uid}: #{self.origin.location.name} to #{self.destination.location.name}"
    else
      self.uid
    end
  end

end
