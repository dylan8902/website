class Trains::Platform < ActiveRecord::Base
  self.table_name = 'train_platforms'


  def self.import filename
    unless File.exist? filename
      logger.error "No file to parse found (#{filename})"
      return false
    end

    File.open(filename).each do |line|
      data = line.split("\t")
      platform = Trains::Platform.where(tiploc: data[2], name: data[3]).first_or_create(length: data[6].to_i)
      puts platform
    end
  end


end