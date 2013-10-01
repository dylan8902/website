class IBeforeEController < ApplicationController
  
  # GET /IbeforeE
  def index 
    Project.find(39).hit
  end
 
end