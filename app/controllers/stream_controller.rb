class StreamController < ApplicationController
  
  # GET /stream
  def index
    Project.find(16).hit
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects, callback: params[:callback] }
      format.xml { render xml: @projects }
    end
  end
 
end