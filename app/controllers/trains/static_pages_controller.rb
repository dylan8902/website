class Trains::StaticPagesController < ApplicationController

  # GET /trains
  # GET /trains.json
  # GET /trains.xml
  def index
    Project.hit 34

    @journeys =Trains::Journey.where(user_id: 1).limit(5)

    respond_to do |format|
      format.html
      format.xml { render xml: @journeys }
      format.json { render json: @journeys, callback: params['callback'] }
    end
  end

end
