class FeedbackMailer < ActionMailer::Base
  default from: "dyl@anjon.es"
  
  def email(params)
    @name = params['name']
    @email  = params['email']
    @message = params['message']
    unless @name.nil? or @email.nil? or @message.nil?
      mail(to: "dyl@anjon.es", subject: "Website Feedback")
    else
      return false
    end
  end
end
