class Tweet < ActiveRecord::Base
  default_scope order('created_at DESC')

  def self.update
    
    Twitter.configure do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
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
    self.text
  end

end
