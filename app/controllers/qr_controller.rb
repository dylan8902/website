class QrController < ApplicationController
  
  # GET /qr
  def index 
    Project.hit 435
  end
 
end