class Tweet < ApplicationRecord
  default_scope { order('created_at DESC') }

  def self.update

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = Rails.application.secrets.twitter_oauth_token
      config.access_token_secret = Rails.application.secrets.twitter_oauth_token_secret
    end

    begin
      tweets = client.user_timeline("dylan8902")
    rescue => e
      logger.info "Twitter update problem: #{e.message}"
      return
    end
    tweets.each do |tweet|
      unless tweet.geo.nil?
        lat = tweet.geo.coordinates[0]
        lng = tweet.geo.coordinates[1]
      end
      unless tweet.place.nil?
        location = tweet.place.full_name
      end
      Tweet.where(id: tweet.id).first_or_create(
        text: tweet.text,
        location: location,
        lat: lat,
        lng: lng,
        created_at: tweet.created_at,
        updated_at: tweet.created_at
      )
    end

  end

  def map_marker_text
    self.text
  end

end
