class SamaritansController < ApplicationController
  
  # GET /samaritans
  def index 
    Project.find(49).hit
  end
 
end