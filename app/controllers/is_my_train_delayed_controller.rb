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

    unless @from.nil? and @to.nil?
      @trains = get_trains(@from, @to, @departing)
    end

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

    unless @from.nil? and @to.nil?
      @trains = get_trains(@from, @to, @departing)
    end

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

    @train = get_service params[:service]

    respond_to do |format|
      format.html
      format.json { render json: @trains, callback: params[:callback] }
      format.xml { render xml: @trains }
    end
  end


  # GET /stations
  # GET /stations.json
  # GET /stations.xml
  def stations
    if params['lat'] and params['lng']
      @stations =  []
    end

    respond_to do |format|
      format.html
      format.json { render json: @stations, callback: params[:callback] }
      format.xml { render xml: @stations }
    end
  end


  private

    def get_trains(from, to, departing)
      if departing
        url = "https://huxley.apphb.com/departures/#{Rack::Utils.escape(from)}"
        if to and !to.empty?
          url << "/to/#{Rack::Utils.escape(to)}"
        end
      else
        url = "https://huxley.apphb.com/arrivals/#{Rack::Utils.escape(from)}"
        if to and !to.empty?
          url << "/from/#{Rack::Utils.escape(to)}"
        end
      end
      api_call url
    end


    def get_service service
      return unless service
      api_call "https://huxley.apphb.com/service/#{Rack::Utils.escape(service)}"
    end


    def api_call url

      begin
        response = RestClient.get url + "?expand=true&accessToken=DA1C7740-9DA0-11E4-80E6-A920340000B1"
      rescue Exception => e
        logger.error "#{Time.now} Could not get service details: #{e.message}"
        return []
      end

      return [] if response.code != 200

      begin
        json = JSON.parse(response.body)
        return json
      rescue Exception => e
        logger.error "#{Time.now} Could not get trains: #{e.message}"
        return []
      end

    end

end
