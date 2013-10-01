class ConvictsController < ApplicationController
  
  # GET /nght11
  def index
    Project.find(28).hit
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
