require 'open-uri'
class TextMessage < ActiveRecord::Base
  attr_accessible :contact, :text, :sent, :created_at, :updated_at
    
  default_scope order('created_at DESC')
  
  def self.update_url
    "https://dl.dropboxusercontent.com/sh/ubukii3foribrrz/G5hiE5qYld/sms.xml?token_hash=AAGxzw22f-4svibsz3kDKQYLD3f1nyErWK5XTvbyKeBuzg"
  end
  
  def self.normalise_phone_number number
    number = number.gsub(' ','').gsub('+','')
    if number.start_with? '0' and number.length == 11
      number = "44" + number[1..-1]
    end
    return number
  end
  
  
  def self.update
    xml = Nokogiri::XML(open('sms.xml'))
    xml.css('sms').each do |sms|
      TextMessage.create(
        text: sms.attribute('body').value,
        sent: sms.attribute('type').value.to_i - 1,
        contact: TextMessage.normalise_phone_number(sms.attribute('address').value),
        created_at: DateTime.parse(sms.attribute('readable_date')),
        updated_at: DateTime.now
      )
    end
  end

end
