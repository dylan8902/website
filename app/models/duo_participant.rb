class DuoParticipant < ApplicationRecord
  has_and_belongs_to_many :duo_leaderboards
  validates :id, presence: true, uniqueness: true
  validates :name, presence: true

  def xp
    self.class.api_call "/users/#{self.id}/xp_summaries"
  end

  def self.get id
    json = api_call "/users/#{id}?fields=username,name,totalXp,picture,id"
    return nil if json.nil?

    participant = DuoParticipant.where(
      id: json["id"]
    ).first_or_initialize

    participant.name = json["name"] || json["username"]
    participant.photo =  "https:#{json["picture"]}/xlarge"
    participant.save

    return participant
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
