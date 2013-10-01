class TweetsController < ApplicationController
  include Statistics
  
  # GET /tweets
  # GET /tweets.json
  # GET /tweets.xml
  def index
    @tweets = Tweet.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tweets, callback: params[:callback] }
      format.xml { render xml: @tweets }
    end
  end

  # GET /tweets/1
  # GET /tweets/1.json
  # GET /tweets/1.xml
  def show
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweet, callback: params[:callback] }
      format.xml { render xml: @tweet }
    end
  end
  
  # GET /tweets/stats
  # GET /tweets/stats.json
  # GET /tweets/stats.xml
  def stats
   @stats = time_data Tweet.all
    
    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(Tweet.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Tweet.all, :hash) }
    end
  end
  
  # GET /tweets/map
  # GET /tweets/map.json
  # GET /tweets/map.xml
  def map
    Project.find(9).hit
    @locations = Tweet.where("lat IS NOT NULL AND lng IS NOT NULL")
    
    respond_to do |format|
      format.html # map.html.erb
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end

end
