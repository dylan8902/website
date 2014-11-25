class Location < ActiveRecord::Base
  default_scope { order('created_at DESC') }


  def google_image size = 160
    "https://maps.googleapis.com/maps/api/staticmap?center=#{lat},#{lng}&zoom=11&size=#{size}x#{size}&sensor=true"
  end


  def self.get_kml start_time, end_time
    url = "https://www.google.com/accounts/ClientLogin"
    data = {
      "accountType" => "HOSTED_OR_GOOGLE",
      "Email" => ENV['GOOGLE_LOCATION_EMAIL'],
      "Passwd" => ENV['GOOGLE_LOCATION_PASSWORD'],
      "source" => "website",
      "service" => "friendview"
    }

    response = RestClient.post url, data
    auth = response.body.split("Auth=")[1]
    url = "https://maps.google.com/locationhistory/b/0/kml?startTime=#{start_time}000&endTime=#{end_time}000"
    begin
      response = RestClient.get url, "Authorization" => "GoogleLogin auth=#{auth}"
      return response.body
    rescue => e
      logger.info "Location update problem: " + e.message
      return
    end
  end


  def self.update
    if Location.last
      start_time = Location.first.created_at.to_i
    else
      start_time = 1275350400
    end
    
    end_time = start_time + 2628000
    response = Location.get_kml(start_time, end_time)
    return if response.nil?
    
    kml = Nokogiri::XML(response)
    when_elements = kml.css('when')
    coord_elements = kml.css('gx|coord')
    when_elements.each_with_index do |timestamp, i|
      xy = coord_elements[i].text.split(" ")
      timestamp = DateTime.parse(timestamp.text).utc
      Location.where(lat: BigDecimal.new(xy[1]), lng: BigDecimal.new(xy[0]), created_at: timestamp).first_or_create
    end
  end


end