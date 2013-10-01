class LocationsController < ApplicationController
  
  # GET /locations
  # GET /locations.json
  # GET /locations.xml
  def index
    Project.find(4).hit
    @locations = Location.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations, methods: [:lat, :lng], callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end
  

  # GET /locations/1
  # GET /locations/1.json
  # GET /locations/1.xml
  def show
    Project.find(4).hit
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location, methods: [:lat, :lng], callback: params[:callback] }
      format.xml { render xml: @location }
    end
  end

end
