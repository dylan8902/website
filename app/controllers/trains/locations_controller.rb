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
      distance = "7912*ASIN(SQRT(POWER(SIN((lat-#{params['lat']})*pi()/180/2),2)+COS(lat*pi()/180)*COS(#{params['lat']}*pi()/180)*POWER(SIN((lng-#{params['lng']})*pi()/180/2),2)))"
      @locations =  Trains::Location.select("train_locations.*, #{distance} AS distance").where("lat IS NOT NULL AND lng IS NOT NULL").paginate(@page)
    else
      @page[:order] = params[:order] || "name ASC"
      crs = Trains::Location.where("crs = ? AND (#{stations})", @q)
      tiploc = Trains::Location.where("tiploc = ? AND (#{stations})", @q)
      name =  Trains::Location.where("name LIKE ? AND (#{stations})", "#{@q}%")
      @locations = [crs, tiploc, name]
      @locations = @locations.flatten.uniq.paginate(@page)
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


  # GET /trains/locations/map
  # GET /trains/locations/map.json
  # GET /trains/locations/map.xml
  def map
    @locations =Trains::Location.where("lat IS NOT NULL AND lng IS NOT NULL")

    respond_to do |format|
      format.html
      format.xml { render xml: @locations }
      format.json { render json: @locations, callback: params['callback'] }
    end

  end

end
