class StreamController < ApplicationController
  
  # GET /stream
  def index
    Project.hit 16
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects, callback: params[:callback] }
      format.xml { render xml: @projects }
    end
  end
 
end