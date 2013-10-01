class Trains::StaticPagesController < ApplicationController

  def index
    Project.find(34).hit

    respond_to do |format|
      format.html
      format.xml { render xml: @schedules }
      format.json { render json: @schedules, callback: params['callback'] }
    end
  end

end
