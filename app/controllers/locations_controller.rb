class LocationsController < ApplicationController


  # GET /locations
  # GET /locations.json
  # GET /locations.xml
  def index
    Project.hit 4
    @page[:per_page] = params[:limit] || 100
    @locations = Location.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end


  # GET /locations/1
  # GET /locations/1.json
  # GET /locations/1.xml
  def show
    Project.hit 4
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location, callback: params[:callback] }
      format.xml { render xml: @location }
    end
  end

end
