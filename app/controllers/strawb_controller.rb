class StrawbController < ApplicationController

  # GET /strawb
  # GET /strawb.json
  # GET /strawb.xml
  # POST /strawb
  # POST /strawb.json
  # POST /strawb.xml
  def index

    puts params
    @response = {
      "type": "message",
      "text": "Strawbed ya!"
    }

    respond_to do |format|
      format.html { render json: @response, callback: params[:callback] }
      format.json { render json: @response, callback: params[:callback] }
      format.xml { render xml: @response}
    end
  end

end
