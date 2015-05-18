class TrainsController < ApplicationController
  include Statistics


  # GET /trains
  # GET /trains.json
  # GET /trains.xml
  def index
    @trains = Train.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trains, callback: params[:callback] }
      format.xml { render xml: @trains }
      format.rss { render 'feed' }
    end
  end


  # GET /trains/all
  # GET /trains/all.json
  # GET /trains/all.xml
  def all
    @page[:per_page] = Train.count
    @trains = Train.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @trains, callback: params[:callback] }
      format.xml { render xml: @trains }
      format.rss { render 'feed' }
    end
  end


  # GET /trains/1
  # GET /trains/1.json
  # GET /trains/1.xml
  def show
    @train = Train.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @train, callback: params[:callback] }
      format.xml { render xml: @train }
    end
  end


  # GET /trains/stats
  # GET /trains/stats.json
  # GET /trains/stats.xml
  def stats
   @stats = time_data Train.all
   @cloud = word_cloud Train.pluck(:origin)
 
    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(Train.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Train.all, :hash) }
    end
  end


  # GET /tweets/map
  # GET /tweets/map.json
  # GET /tweets/map.xml
  def map
    @locations = Train.where("lat IS NOT NULL AND lng IS NOT NULL")
    
    respond_to do |format|
      format.html # map.html.erb
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end

end
