class ChristmasJumperDonation < ApplicationRecord

  PROJECT = "pub-tracker-live"
  BASE_URL = "https://firestore.googleapis.com/v1/projects/#{PROJECT}/databases/(default)/documents"
  DONATIONS_URL = "https://api.justgiving.com/904af047/v1/fundraising/pages/cjd240033091/donations"


  def self.get_donations
    begin
      response = JSON.parse(RestClient.get(DONATIONS_URL, accept: "application/json").body)
      return response["donations"]
    rescue => e
      logger.info "Get donations problem: " + e.message
      return
    end
  end


  def self.set_christmas_jumper_hat user_id
    data = {
      "fields": {
        "equipped": {
          "mapValue": {
            "fields": {
              "hat": { "stringValue": "https://dyl.anjon.es/images/jumper.png" }
            }
          }
        }
      }
    }
    url = "#{BASE_URL}/profiles/#{user_id}?mask.fieldPaths=equipped.hat&updateMask.fieldPaths=equipped.hat"
    response = RestClient.patch(url, data.to_json, content_type: :json)
  end


  def self.update_pub_thursday_user justgiving_name
    response = JSON.parse(RestClient.get("#{BASE_URL}/users?pageSize=100&mask.fieldPaths=displayName").body)
    response["documents"].each do |user|
      name = user["fields"]["displayName"]["stringValue"]
      if name.strip.downcase.eql? justgiving_name.strip.downcase
        user_id = user["name"].gsub("projects/#{PROJECT}/databases/(default)/documents/users/", "")
        self.set_christmas_jumper_hat(user_id)
      end
    end
  end


  def self.update
    self.get_donations().each do |donation|
      justgiving_id = donation["id"].to_s
      justgiving_name = donation["donorDisplayName"]
      next if ChristmasJumperDonation.exists?(donation_id: justgiving_id)

      begin
        self.update_pub_thursday_user(justgiving_name)
      rescue => e
        logger.info "Failed to update pub thursday_user #{justgiving_name}: " + e.message
      end

      ChristmasJumperDonation.create({
        donation_id: justgiving_id,
        name: justgiving_name
      })
    end
    return
  end

end
