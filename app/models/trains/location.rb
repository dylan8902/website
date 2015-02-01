class Trains::Location < ActiveRecord::Base
  self.table_name = "train_locations"


  def station?
    self.station
  end


  def scheduled_departures time = Time.now, public = true 
    Trains::Schedule.get_schedules self, nil, time, public
  end


  def scheduled_arrivals time = Time.now, public = true 
    Trains::Schedule.get_schedules nil, self, time, public
  end


  def platforms
    Trains::Platform.where(tiploc: self.tiploc)
  end


  def network_links
    Trains::LocationDistance.where(origin_tiploc: self.tiploc).order("initial_direction DESC")
  end


  def station_plan
    "http://www.nationalrail.co.uk/SME/html/NRE_#{self.crs}/plan.html"
  end


  def self.network_link origin, destination, line
    return nil if origin.nil? or destination.nil?
    sql = "(origin_tiploc = ? AND destination_tiploc = ?) OR (destination_tiploc = ? AND origin_tiploc = ?)"
    results = Trains::LocationDistance.where(sql, origin.tiploc, destination.tiploc, destination.tiploc, origin.tiploc)
    results.each do |result|
      return result if line == result.line
    end
    return results.first if results.first
    return nil
  end


  def map_image

    return nil unless lat and lng

    url = "https://maps.googleapis.com/maps/api/staticmap?center=#{self.lat},#{self.lng}&zoom=14&size=320x320&sensor=false"
    link = "<a data-toggle=\"modal\" href=\"#map-modal\"><img src=\"#{url}\" alt=\"Map of #{self.name}\" class=\"img-circle\"></a>"
    src = "https://maps.google.com/maps?ll=#{self.lat},#{self.lng}&amp;z=15&amp;output=embed"
    modal = "
    <section class=\"modal fade\" id=\"map-modal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"Map\" aria-hidden=\"true\">
      <section class=\"modal-dialog\">
        <article class=\"modal-content\">
          <header class=\"modal-header\">
            <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>
            <h4 class=\"modal-title\">Map</h4>
          </header>
          <div class=\"modal-body\">
            <iframe width=\"640\" height=\"480\" frameborder=\"0\" scrolling=\"no\" marginheight=\"0\" marginwidth=\"0\" src=\"#{src}\"></iframe>
          </div>
        </article>
      </section>
    </section>"

    return (link + modal).html_safe
  end


  def to_s
    self.name
  end


  def self.import filename
    unless File.exist? filename
      logger.error "No file to parse found (#{filename})"
      return false
    end

    File.open(filename).each do |line|
      data = line.split("\t")
      if data[6].to_i != 999999 and data[6].to_i != 0 and data[7].to_i != 999999 and data[7].to_i != 0
        ll = BlueGeo.easting_northing_to_lat_lon(data[6].to_i, data[7].to_i)
      else
        ll = [nil, nil]
      end
      location = { name: data[3], tiploc: data[2], lat: ll[0], lng: ll[1] }
      update = Trains::Location.where(tiploc: location[:tiploc], lat: nil, lng: nil).first
      update.update_attributes(lat: location[:lat], lng: location[:lng]) if update
    end
  end


  def map_marker_text
    "#{self.id}. #{self.name} - #{self.lat}, #{self.lng}"
  end

end