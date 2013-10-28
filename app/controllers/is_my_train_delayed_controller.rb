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
    
    @trains = get_trains

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

    @trains = get_trains

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
    @service = params[:service]

    @trains = get_service

    respond_to do |format|
      format.html 
      format.json { render json: @trains, callback: params[:callback] }
      format.xml { render xml: @trains }
    end
  end


  private
    def get_trains

      if @from
        url = "http://ojp.nationalrail.co.uk/service/ldb/liveTrainsJson?departing="
        if @departing
          url << "true"
        end
        url << "&liveTrainsFrom=#{URI::escape(@from)}&liveTrainsTo=#{URI::escape(@to)}&from=#{URI::escape(@from)}&to=#{URI::escape(@to)}"
      else
        return []
      end

      begin
        response = RestClient.get url
      rescue Exception => e
        logger.error "#{Time.now} Could not get trains: #{e.message}"
        return []
      end

      return [] if response.code != 200
      return JSON.parse(response.body)['trains']
    end


    def get_service

      return unless @service
      url = "http://ojp.nationalrail.co.uk/service/ldbdetailsJson?serviceId=#{URI::escape(@service)}"

      begin
        response = RestClient.get url
      rescue Exception => e
        logger.error "#{Time.now} Could not get service details: #{e.message}"
        return []
      end

      return [] if response.code != 200
      return JSON.parse(response.body)['trains']
    end

end