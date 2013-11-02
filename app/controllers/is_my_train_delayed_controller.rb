class IsMyTrainDelayedController < ApplicationController
  layout "is_my_train_delayed"


  # GET /
  # GET /.json
  # GET /.xml
  def departures
    Project.hit 35
    @departing = true
    @from = params[:from]
    @to = params[:to]
    
    @trains = get_trains(@from, @to, @departing) unless @from.nil? and @to.nil?

    respond_to do |format|
      format.html
      format.json { render json: @trains, callback: params[:callback] }
      format.xml { render xml: @trains }
    end
  end


  # GET /arrivals
  # GET /arrivals.json
  # GET /arrivals.xml
  def arrivals
    Project.hit 35
    @departing = false
    @from = params[:from]
    @to = params[:to]

    @trains = get_trains(@from, @to, @departing) unless @from.nil? and @to.nil?

    respond_to do |format|
      format.html 
      format.json { render json: @trains, callback: params[:callback] }
      format.xml { render xml: @trains }
    end
  end


  # GET /service
  # GET /service.json
  # GET /service.xml
  def service
    Project.hit 35

    @trains = get_service params[:service]

    respond_to do |format|
      format.html 
      format.json { render json: @trains, callback: params[:callback] }
      format.xml { render xml: @trains }
    end
  end


  # GET /station
  # GET /station.json
  # GET /station.xml
  def stations
    if params['lat'] and params['lng']
      @page[:order] = params[:order] || "distance ASC"
      distance = "7912*ASIN(SQRT(POWER(SIN((lat-#{params['lat']})*pi()/180/2),2)+COS(lat*pi()/180)*COS(#{params['lat']}*pi()/180)*POWER(SIN((lng-#{params['lng']})*pi()/180/2),2)))"
      @stations =  Trains::Location.select("train_locations.*, #{distance} AS distance").where("lat IS NOT NULL AND lng IS NOT NULL").paginate(@page)
    end

    respond_to do |format|
      format.html 
      format.json { render json: @stations, callback: params[:callback] }
      format.xml { render xml: @stations }
    end
  end


  private
    def get_trains(from, to, departing)
      if from
        url = "http://ojp.nationalrail.co.uk/service/ldb/liveTrainsJson?departing="
        if departing
          url << "true"
        end
        url << "&liveTrainsFrom=#{URI::escape(from)}&liveTrainsTo=#{URI::escape(to)}&from=#{URI::escape(from)}&to=#{URI::escape(to)}"
      else
        return []
      end
      api_call url
    end


    def get_service service
      return unless service
      api_call "http://ojp.nationalrail.co.uk/service/ldbdetailsJson?serviceId=#{Rack::Utils.escape(service)}"
    end


    def api_call url

      begin
        response = RestClient.get url
      rescue Exception => e
        logger.error "#{Time.now} Could not get service details: #{e.message}"
        return []
      end

      return [] if response.code != 200

      begin
        json = JSON.parse(response.body)
        return json['trains']
      rescue Exception => e
        logger.error "#{Time.now} Could not get trains: #{e.message}"
        return []
      end

    end

end