class MollyController < ApplicationController
  
  # GET /molly
  def index
    Project.hit 47
    unless params[:text]
      params[:text] = "Where Can I Find Molly?"
    end
  end
 
end