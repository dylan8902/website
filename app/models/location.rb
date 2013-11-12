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
    response = RestClient.get url, "Authorization" => "GoogleLogin auth=#{auth}"
    return response.body
  end


  def self.update
    if Location.last
      start_time = Location.last.created_at.to_i
    else
      start_time = 1275350400
    end
    end_time = start_time + 2628000

    kml = Nokogiri::XML(Location.get_kml(start_time, end_time))
    when_elements = kml.css('when')
    coord_elements = kml.css('gx|coord')
    when_elements.each_with_index do |timestamp, i|
      xy = coord_elements[i].text.split(" ")
      timestamp = DateTime.parse(timestamp.text)
      Location.create(lat: xy[1], lng: xy[0], created_at: timestamp) unless Location.where("UNIX_TIMESTAMP(created_at) = ?", timestamp.to_i).count > 0
    end
  end


end