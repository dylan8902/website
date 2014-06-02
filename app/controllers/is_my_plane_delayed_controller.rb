class IsMyPlaneDelayedController < ApplicationController
  layout "is_my_plane_delayed"


  # GET /
  # GET /.json
  # GET /.xml
  def departures
   # Project.hit 35
    @departing = true
    @from = params[:from]
    @to = params[:to]
    
    unless @from.nil? and @to.nil?
      @planes = get_flights(@from, @to, @departing)
      @airports = did_you_mean @from, @to if @planes == []
    end
 
    respond_to do |format|
      format.html
      format.json { render json: @planes, callback: params[:callback] }
      format.xml { render xml: @planes }
    end
  end


  # GET /arrivals
  # GET /arrivals.json
  # GET /arrivals.xml
  def arrivals
    #Project.hit 35
    @departing = false
    @from = params[:from]
    @to = params[:to]

    unless @from.nil? and @to.nil?
      @planes = get_flights(@from, @to, @departing)
      @airports = did_you_mean @from, @to if @planes == []
    end

    respond_to do |format|
      format.html 
      format.json { render json: @planes, callback: params[:callback] }
      format.xml { render xml: @planes }
    end
  end


  # GET /flight
  # GET /flight.json
  # GET /flight.xml
  def flight
    #Project.hit 35

    @planes = get_flight params[:flighte]

    respond_to do |format|
      format.html 
      format.json { render json: @planes, callback: params[:callback] }
      format.xml { render xml: @planes }
    end
  end


  # GET /airports
  # GET /airports.json
  # GET /airports.xml
  def airports
    if params['lat'] and params['lng']
      @order = params[:order] || "distance ASC"
      distance = "7912*ASIN(SQRT(POWER(SIN((lat-#{params['lat']})*pi()/180/2),2)+COS(lat*pi()/180)*COS(#{params['lat']}*pi()/180)*POWER(SIN((lng-#{params['lng']})*pi()/180/2),2)))"
      @locations =  Airport.select("airports.*, #{distance} AS distance").where("lat IS NOT NULL AND lng IS NOT NULL").order(@order).paginate(@page)
    else
      @locations =  Airport.all
    end

    respond_to do |format|
      format.html 
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end


  private
    def did_you_mean(from, to)
      airports = { from: [], to: [] }
      airports[:from] = Airport.where("name LIKE ? OR iata = ?", "%#{from}%", "%#{from}%").limit(5) unless from.empty?
      airports[:to] = Airport.where("name LIKE ? OR iata = ?", "%#{to}%", "%#{to}%").limit(5) unless to.empty?
      return airports
    end


    def get_flights(from, to, departing)
     []
    end


    def get_flight flight
      return nil
    end


end