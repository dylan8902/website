class MollyController < ApplicationController
  
  # GET /molly
  def index
    Project.find(47).hit
    unless params[:text]
      params[:text] = "Where Can I Find Molly?"
    end
  end
 
end