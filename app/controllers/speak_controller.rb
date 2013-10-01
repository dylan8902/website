class SpeakController < ApplicationController
  
  # GET /speak
  def index
    Project.find(23).hit
  end
 
end