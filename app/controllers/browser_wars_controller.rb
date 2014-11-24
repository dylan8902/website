class BrowserWarsController < ApplicationController


  # GET /browserwars
  # GET /browserwars.json
  # GET /browserwars.xml
  def index
    Project.hit 27
    
    filename = Rails.root.join("json", "browser_wars.json")
    if File.exists?(filename) and File.mtime(filename) > Time.now - 1.day      
      @browsers = JSON.load filename
    else

      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_OAUTH_TOKEN']
        config.access_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
      end
      browsers = client.users('opera', 'firefox', 'ie', 'googlechrome', 'AppleSafari')
      File.open(filename, "w") do |f|
        f.write(browsers.to_json)
      end
      @browsers = JSON.load filename

    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @browsers, callback: params[:callback] }
      format.xml { render xml: @browsers }
    end
  end

end
