require 'open-uri'
class TextMessage < ApplicationRecord
  default_scope { order('created_at DESC') }


  def self.normalise_phone_number number
    number = number.gsub(' ','').gsub('+','')
    if number.start_with? '0' and number.length == 11
      number = "44" + number[1..-1]
    end
    return number
  end


  def self.update
    begin
      xml = Nokogiri::XML(open(Rails.application.secrets.sms_link))
    rescue => e
      logger.info "Text message update problem: " + e.message
      return
    end
    xml.css('sms').each do |sms|
      TextMessage.where(
        text: sms.attribute('body').value,
        sent: sms.attribute('type').value.to_i - 1,
        contact: TextMessage.normalise_phone_number(sms.attribute('address').value),
        created_at: DateTime.parse(sms.attribute('readable_date')),
      ).first_or_create(updated_at: DateTime.now)
    end
  end


end
