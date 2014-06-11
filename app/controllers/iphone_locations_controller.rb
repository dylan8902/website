class IphoneLocationsController < ApplicationController


  # GET /iphone
  # GET /iphone.json
  # GET /iphone.xml
  def index
    Project.hit 31
    @locations = IphoneLocation.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
      format.xml { render xml: @locations }
    end
  end


  # GET /iphone/1
  # GET /iphone/1.json
  # GET /iphone/1.xml
  def show
    Project.hit 31
    @location = IphoneLocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
      format.xml { render xml: @location }
    end
  end

end
