class WeddingRsvpMailer < ApplicationMailer

  def rsvp_email(rsvp)
    @rsvp = rsvp
    mail(to: ["dyl@anjon.es", "timms.alice@gmail.com"], subject: "Wedding RSVP") do |format|
     format.html
     format.text
   end
  end

end
