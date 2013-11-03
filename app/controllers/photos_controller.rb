class PhotosController < ApplicationController
  include Statistics

  # GET /photos
  # GET /photos.json
  # GET /photos.xml
  def index
    @page[:limit] = params[:limit] || 48
    @photos = Photo.paginate(@page)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos, callback: params[:callback] }
      format.xml { render xml: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo, callback: params[:callback] }
      format.xml { render xml: @photo }
    end
  end

  # GET /photos/stats
  # GET /photos/stats.json
  # GET /photos/stats.xml
  def stats
   @stats = time_data Photo.all
    
    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(Photo.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Photo.all, :hash) }
    end
  end

  # GET /photos/map
  # GET /photos/map.json
  # GET /photos/map.xml
  def map
    @locations = Photo.where("lat IS NOT NULL AND lng IS NOT NULL")
    
    respond_to do |format|
      format.html # map.html.erb
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end

end
