class QrController < ApplicationController
  
  # GET /qr
  def index 
    Project.hit 45
  end
 
end