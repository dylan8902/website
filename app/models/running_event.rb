class RunningEvent < ApplicationRecord


  def timing
    return nil if self.finish_time.nil?
    Time.at(self.finish_time).gmtime.strftime('%R:%S')
  end


  def map_image
    return nil unless self.lat and self.lng

    url = "https://maps.googleapis.com/maps/api/staticmap?center=#{self.lat},#{self.lng}&zoom=12&size=120x120&sensor=false&key=AIzaSyAqRDkk_iuLRFmt5t9iWCLf6v61J4lvIkQ"
    link = "<p><a data-toggle=\"modal\" href=\"#map-modal\"><img src=\"#{url}\" alt=\"Map of #{self.name}\" class=\"img-circle\"></a></p>"
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


  def self.update_from_kml
    # get kml if there are events missing kml
    return if RunningEvent.where(kml: nil).count == 0
    urls = [
      "https://www.google.com/maps/d/kml?mid=zZkcgeP1TSwY.kbwXND1rzFbk&forcekml=1&cid=mp&cv=la3B8yTDoVw.en_GB.",
      "https://www.google.com/maps/d/kml?mid=zZkcgeP1TSwY.kfzxvZaVxzyw&usp=sharing&forcekml=1"
    ]
    begin
      urls.each do |url|
        response = RestClient.get url
        kml = Nokogiri::XML(response.body)
        kml.css('Folder').each do |run|
          title = run.css('name').first.text
          event = RunningEvent.where(name: title).first
          logger.info "The layer name does not match anything in db"
          next if event.nil?

          locations = []
          run.css('coordinates')[0].text.split(' ').each do |coord|
            xyz = coord.split(',')
            locations << Point.new(xyz)
          end

          logger.info "locations: " + locations.to_s
          event.update_attribute(:kml, locations.to_json)
        end
      end
    rescue => e
      logger.info "Location update problem: " + e.message
    end
  end


  def points
    points = []
    return points if self.kml.nil?
    json = JSON.parse(self.kml)
    json.each do |xy|
      points << Point.new([xy["lng"], xy["lat"]])
    end
    return points
  end


  def self.update
    url = "https://www.strava.com/api/v3/athlete/activities?access_token=30182c04d9559207d040240cc80f4d3cf28419ce"
    response = RestClient.get url
    if response.code != 200
      return
    end

    json = JSON.parse response.body
    if json.nil? or json.empty?
      return
    end

    json.each do |activity|
      run = RunningEvent.where(strava_id: activity['id']).first
      if run.nil?
        # Add the new run
        params = {
          strava_id: activity['id'],
          name: activity['name'],
          distance: activity['distance'],
          created_at: Time.parse(activity['start_date']),
          finish_time: activity['elapsed_time'],
          training: true,
          link: "https://www.strava.com/activities/#{activity['id']}"
        }
        if activity['start_latlng'] and activity['start_latlng'].length == 2
          params[:lat] = activity['start_latlng'][0]
          params[:lng] = activity['start_latlng'][1]
        end
        run = RunningEvent.create(params)

        # Get route and add KML
        url = "https://www.strava.com/api/v3/activities/#{activity['id']}?access_token=30182c04d9559207d040240cc80f4d3cf28419ce"
        response = RestClient.get url
        if response.code != 200
          return
        end

        details = JSON.parse response.body
        if details.nil? or details.empty?
          return
        end

        latlngs = Polylines::Decoder.decode_polyline(details['map']['polyline'])
        kml = []
        latlngs.each do |latlng|
          kml << { lat: latlng[0], lng: latlng[1] }
        end
        run.update(kml: kml.to_json)
      end

    end
  end


  class Point
    attr_reader :lat, :lng
    attr_writer :lat, :lng

    def initialize xyz
      @lat = xyz[1]
      @lng = xyz[0]
    end
  end


end
