class WallController < ApplicationController
  
  # GET /wall
  def index 
    Project.find(38).hit
  end

  # POST /wall
  def submit_score 

  end
 
end