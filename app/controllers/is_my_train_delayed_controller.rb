class IsMyTrainDelayedController < ApplicationController
  layout "is_my_train_delayed"


  # GET /
  # GET /.json
  # GET /.xml
  def index
    Project.hit 35
    @departing = true
    @from = params[:from]
    @to = params[:to]

    respond_to do |format|
      format.html # index.html.erb
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
      end
      
      response = RestClient.get url
      return nil if response.code != 200
      return JSON.parse string
    end

end