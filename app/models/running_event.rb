class RunningEvent < ActiveRecord::Base


  def timing
    return nil if self.finish_time.nil?
    Time.at(self.finish_time).gmtime.strftime('%R:%S')
  end


  def map_image
    return nil unless self.lat and self.lng
    
    url = "https://maps.googleapis.com/maps/api/staticmap?center=#{self.lat},#{self.lng}&zoom=12&size=120x120&sensor=false"
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


end