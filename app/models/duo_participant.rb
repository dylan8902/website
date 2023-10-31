class DuoParticipant < ApplicationRecord
  has_and_belongs_to_many :duo_leaderboards

  def xp
    self.class.api_call "/users/#{self.id}/xp_summaries"
  end

  def self.get id
    json = api_call "/users/#{id}?fields=username,name,totalXp,picture,id"
    DuoParticipant.where(
      id: json["id"]
    ).first_or_create.update(
      id: json["id"],
      name: json["name"],
      photo: "https:#{json["picture"]}/xlarge"
    )
  end

  def self.api_call url
    begin
      response = RestClient.get "https://www.duolingo.com/2017-06-30#{url}"
      if response.code != 200
        logger.error response
        return
      end
    rescue => e
      logger.error e.message
      return
    end

    return JSON.parse response.body
  end
end
