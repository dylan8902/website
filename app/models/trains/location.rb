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
  
  
  def station_plan
    "http://www.nationalrail.co.uk/SME/html/NRE_#{self.crs}/plan.html"
  end
  
  
  def map_image
    
    return nil unless lat and lng
    
    url = "https://maps.googleapis.com/maps/api/staticmap?center=#{self.lat},#{self.lng}&zoom=12&size=320x320&sensor=false"
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

end