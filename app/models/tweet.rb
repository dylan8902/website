class Tweet < ActiveRecord::Base
  attr_accessible :lat, :lng, :location, :text, :created_at, :updated_at, :id
  default_scope order('created_at DESC')

  def self.update
    Twitter.configure do |config|
      config.consumer_key       = "lqYBBSVf2wVYXtiXLJWD6w"
      config.consumer_secret    = "8UKtggxFx3OzhBAXHqanc2beo1tA0ZWmN24TRHPWiE"
      config.oauth_token        = "29808366-2jB4oHxgorLE9R6ySRF5CZoXpcuoEGYdh6X1Ol34C"
      config.oauth_token_secret = "aEZwjhk0KQ21yXTZZKI7UM0jVAI3FrTyC1CrGaWxc"
    end
    tweets = Twitter.user_timeline("dylan8902")
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
    self.text.html_safe
  end

end
