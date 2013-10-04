class ConvictsController < ApplicationController
  
  # GET /nght11
  def index
    Project.hit 28
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
