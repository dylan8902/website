class HybridRadio::RadioVisController < ApplicationController

  # GET /hybrid/vis
  def index
    Project.hit 54
  end


  # GET /hybrid/vis/comet
  def comet
    client = Stomp::Client.new("stomp://#{params[:host]}:#{params[:port]}")
    client.subscribe(params[:topic]) do |msg|
      puts msg
      @message = msg
    end
    
    while @message.nil?
      #wait
    end

    client.close

    respond_to do |format|
      format.html # comet.html.erb
      format.json { render json: @message, callback: params[:callback] }
      format.xml { render xml: @message }
    end
  end

end