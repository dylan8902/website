class SamaritansController < ApplicationController
  
  # GET /samaritans
  def index 
    Project.hit 49
  end
 
end