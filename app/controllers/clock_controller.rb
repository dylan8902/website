class ClockController < ApplicationController
  
  # GET /clock
  def index
    Project.find(24).hit
    render layout:false
  end

end
