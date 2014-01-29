class Trains::LocationDistance < ActiveRecord::Base
  self.table_name = 'train_location_distances'


  def origin
    Trains::Location.find_by_tiploc(self.origin_tiploc)
  end


  def destination
    Trains::Location.find_by_tiploc(self.destination_tiploc)
  end


  def self.import filename
    unless File.exist? filename
      logger.error "No file to parse found (#{filename})"
      return false
    end

    File.open(filename).each do |line|
      data = line.split("\t")
      hash = { origin_tiploc: data[2], destination_tiploc: data[3], line: data[4].strip, initial_direction: data[8], final_direction: data[9] }
      Trains::LocationDistance.where(hash).first_or_create(distance: data[10].to_i) unless hash[:line] == "BUS"
    end
  end


end