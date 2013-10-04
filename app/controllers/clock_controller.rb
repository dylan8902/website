class ClockController < ApplicationController
  
  # GET /clock
  def index
    Project.hit 24
    render layout:false
  end

end
