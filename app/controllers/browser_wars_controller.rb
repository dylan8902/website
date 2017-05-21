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
        config.consumer_key        = Rails.application.secrets.twitter_consumer_key
        config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
        config.access_token        = Rails.application.secrets.twitter_oauth_token
        config.access_token_secret = Rails.application.secrets.twitter_oauth_token_secret
      end
      browsers = client.users('opera', 'firefox', 'ie_uk', 'googlechrome', 'AppleSafari', 'MicrosoftEdge')
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
