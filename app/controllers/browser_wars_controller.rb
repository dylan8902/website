class BrowserWarsController < ApplicationController
  
  # GET /browserwars
  # GET /browserwars.json
  # GET /browserwars.xml
  def index
    Project.find(27).hit
    
    filename = Rails.root.join("json", "browser_wars.json")
    if File.exists?(filename) and File.mtime(filename) > Time.now - 1.day      
      @browsers = JSON.load filename
    else

      Twitter.configure do |config|
        config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
        config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
        config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
      end
      browsers = Twitter.users('opera', 'firefox', 'ie', 'googlechrome', 'AppleSafari')
      @bowsers = browsers.to_json
      
      File.open(filename, "w") do |f|
        f.write(@bowsers)
      end
      
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @browsers, callback: params[:callback] }
      format.xml { render xml: @browsers }
    end
  end

end
