class AnalysisController < ApplicationController

  # GET /analysis
  def index 
    Project.hit 30
  end

end