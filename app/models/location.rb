class Location < ActiveRecord::Base
  attr_accessible :latE7, :lngE7, :accuracy, :text, :created_at, :updated_at
  default_scope order('created_at DESC')
  
  def google_image size = 90
    "https://maps.googleapis.com/maps/api/staticmap?center=#{lat},#{lng}&zoom=11&size=#{size}x#{size}&sensor=true"
  end
  
  def lat
    self.latE7 / 10000000.0
  end
  
  def lng
    self.lngE7 / 10000000.0
  end
  
  def self.parse_file
    file = "LocationHistory.json"
    
    unless File.exist? file
      logger.error "No file to parse found (#{file})"
      return false
    end
    
    file = open(file)
    json = file.read
    
    locations = JSON.parse(json)
    
    puts "Number of location data points: #{locations["locations"].count}"
    
    locations["locations"].each do |location|
      Location.create(
      latE7: location["latitudeE7"],
      lngE7: location["longitudeE7"],
      accuracy: location["accuracy"],
      created_at: Time.at(location["timestampMs"][0..9].to_i),
      text: "Unknown"
     )
    end
    
    
  end
  
end
