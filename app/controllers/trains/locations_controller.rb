require 'will_paginate/array'
class Trains::LocationsController < ApplicationController
  include ApplicationHelper


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
      lat = params['lat'].to_f
      lng = params['lng'].to_f
      @order = params[:order] || "distance ASC"
      @locations =  Trains::Location.select("train_locations.*, #{distance_sql(lat,lng)} AS distance").where("lat IS NOT NULL AND lng IS NOT NULL").order(@order).paginate(@page)
    else
      @order = params[:order] || "name ASC"
      crs = Trains::Location.where("crs = ? AND (#{stations})", @q).order(@order)
      tiploc = Trains::Location.where("tiploc = ? AND (#{stations})", @q).order(@order)
      name =  Trains::Location.where("name LIKE ? AND (#{stations})", "#{@q}%").order(@order)
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

    @og = {
        "og:title" => @location,
        "og:type" => "train-track:station",
        "og:url" => request.original_url,
        "og:image" => "https://maps.google.com/maps?ll=#{@location.lat},#{@location.lng}&amp;z=15&amp;output=embed",
        "og:site_name" => "dyl.anjon.es",
        "fb:app_id" => "272514462916508",
        "train-track:crs" => @location.crs
      }

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
