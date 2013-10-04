class WallController < ApplicationController
  
  # GET /wall
  def index 
    Project.hit 38
  end

  # POST /wall
  def submit_score 

  end
 
end