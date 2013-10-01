class AnalysisController < ApplicationController
  
  # GET /analysis
  def index 
    Project.find(30).hit
  end
 
end