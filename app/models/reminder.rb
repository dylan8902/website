class Reminder < ApplicationRecord
  validates :name, presence: true
  validates :title, presence: true
  validates :time, presence: true
  validates :url, presence: true
  default_scope { order('created_at DESC') }

  TEST_URL = "https://outlook.office.com/webhook/4693544f-084f-410a-9167-cb1fc6f9f274@a7f35688-9c00-4d5e-ba41-29f146377ab0/IncomingWebhook/b489b83c9a114f1da2bbcdb78fcdec7e/93ebf645-dc94-4f05-9e53-936087b0628f"
  LIVE_URL = "https://outlook.office.com/webhook/f3eb15f0-78d2-4d30-834f-f85621c28052@a7f35688-9c00-4d5e-ba41-29f146377ab0/IncomingWebhook/05ced05d4aed49eb98bb1ac52bbdfd81/93ebf645-dc94-4f05-9e53-936087b0628f"

  def to_s
    return "#{time} - #{name}"
  end


  def reminder
    msg = {
    	"@type": "MessageCard",
    	"@context": "http://schema.org/extensions",
    	"themeColor": "0078D7",
      "title": title,
      "text": summary,
    	"sections": [
    		{
    			"activityTitle": title,
    			"activitySubtitle": summary
    		}
    	],
    	"potentialAction": []
    }
    if image and !image.empty?
      msg[:sections][0][:activityImage] = image
    end
    if url and !url.empty?
      msg[:potentialAction] << {
        "@type": "OpenUri",
        "name": "Open Link",
        "targets": [
          { "os": "default", "uri": url}
        ]
      }
    end

    return msg.to_json
  end


  def send
    begin
      response = RestClient.post TEST_URL, self.reminder, {content_type: :json, accept: :json}
      logger.info "#{Time.now} Reminder response: #{response.inspect}"
    rescue Exception => e
      logger.error "#{Time.now} Could not send reminder: #{e.message}"
    end
  end


end
