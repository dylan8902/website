class Train < ApplicationRecord
  default_scope { order('created_at DESC') }

  def self.update
    begin
      response = RestClient.get "http://traintrackapp.co.uk/users/dylan8902.json"
    rescue => e
      logger.info "Train Track problem: " + e.message
      return
    end
    return if response.code != 200
    json = JSON.parse response.body

  end

  def to_s
    "#{origin} to #{destination}"
  end

  def map_marker_text
    self.to_s
  end

end
