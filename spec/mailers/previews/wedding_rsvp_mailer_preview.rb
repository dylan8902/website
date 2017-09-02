# Preview all emails at http://localhost:3000/rails/mailers/wedding_rsvp_mailer
class WeddingRsvpMailerPreview < ActionMailer::Preview
  def rsvp_email
    WeddingRsvpMailer.rsvp_email(Wedding::Rsvp.last)
  end
end
