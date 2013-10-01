class QrController < ApplicationController
  
  # GET /qr
  def index 
    Project.find(35).hit
  end
 
end