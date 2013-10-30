require 'will_paginate/array'
class Trains::LocationsController < ApplicationController


  # GET /trains/locations
  # GET /trains/locations.json
  # GET /trains/locations.xml
  def index
    @q = params['q']

    if params['stations']
      stations = "station = 1"
    else
      stations = "station = 1 OR station = 0"
    end

    if params['lat'] and params['lng']
      @page[:order] = params[:order] || "distance ASC"
      distance = "(#{params['lat']})*cos(radians(lat))*cos(radians(lng)-radians(#{params['lng']}))+sin(radians(#{params['lat']}))*sin(radians(lat)) AS distance"
      @locations =  Trains::Location.select("locations.*, #{distance}").paginate(@page)
    else
      @page[:order] = params[:order] || "name ASC"
      crs = Trains::Location.where("crs = ? AND (#{stations})", @q)
      tiploc = Trains::Location.where("tiploc = ? AND (#{stations})", @q)
      name =  Trains::Location.where("name LIKE ? AND (#{stations})", "#{@q}%")
      @locations = [crs, tiploc, name]
      @locations = @locations.flatten.paginate(@page)
    end

    respond_to do |format|
      format.html
      format.xml { render xml: @locations }
      format.json { render json: @locations, callback: params['callback'] }
    end

  end


  # GET /trains/locations/1
  # GET /trains/locations/1.json
  # GET /trains/locations/1.xml
  def show
    @location =Trains::Location.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render xml: @location }
      format.json { render json: @location, callback: params['callback'] }
    end

  end

end
