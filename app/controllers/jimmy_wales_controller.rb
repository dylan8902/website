class JimmyWalesController < ApplicationController
  
  # GET /jimmywales
  def index
    Project.find(20).hit
  end
 
end