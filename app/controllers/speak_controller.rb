class SpeakController < ApplicationController
  
  # GET /speak
  def index
    Project.hit 23
  end
 
end