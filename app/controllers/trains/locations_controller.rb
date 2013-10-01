class Trains::LocationsController < ApplicationController

  def index
    @q = params['q']

    if params['stations'] 
      stations = "station = 1"
    else
      stations = "station = 1 OR station = 0"
    end
    
    if params['lat'] and params['lng'] then
      distance = "(#{params['lat']})*cos(radians(lat))*cos(radians(lng)-radians(#{params['lng']}))+sin(radians(#{params['lat']}))*sin(radians(lat)) AS distance"
      @locations =  Trains::Location.select("locations.*, #{distance}").order(:distance).paginate(@page) 
    else
      @locations =  Trains::Location.where("(crs = ? OR tiploc = ? OR name LIKE ?) AND (#{stations})", @q, @q, "#{@q}%").paginate(@page)
    end

    respond_to do |format|
      format.html
      format.xml { render xml: @locations }
      format.json { render json: @locations, callback: params['callback'] }
    end

  end


  def show
    @location =Trains::Location.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render xml: @location }
      format.json { render json: @location, callback: params['callback'] }
    end

  end

end
