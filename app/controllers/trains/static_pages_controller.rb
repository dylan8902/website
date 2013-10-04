class Trains::StaticPagesController < ApplicationController

  # GET /trains
  # GET /trains.json
  # GET /trains.xml
  def index
    Project.hit 34

    respond_to do |format|
      format.html
      format.xml { render xml: @schedules }
      format.json { render json: @schedules, callback: params['callback'] }
    end
  end

end
