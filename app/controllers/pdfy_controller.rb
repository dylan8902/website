class PdfyController < ApplicationController
  
  # GET /pdfy
  def index 
    Project.find(41).hit
  end
  
  # POST /pdfy
  def pdfy
  end
 
end