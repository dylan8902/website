class JimmyWalesController < ApplicationController
  
  # GET /jimmywales
  def index
    Project.hit 20
  end
 
end