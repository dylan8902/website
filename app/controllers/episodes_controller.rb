class EpisodesController < ApplicationController
  include Statistics
  
  # GET /episodes
  # GET /episodes.json
  def index
    Project.find(13).hit
    @episodes = Episode.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @episodes, callback: params[:callback] }
      format.xml { render xml: @episodes }
    end
  end


  # GET /episodes/1
  # GET /episodes/1.json
  # GET /episodes/1.xml
  def show
    Project.find(13).hit
    @episode = Episode.find_by_pid(params[:id]) or not_found

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @episode, callback: params[:callback] }
      format.xml { render xml: @episode }
    end
  end
  
  
  # GET /episodes/stats
  # GET /episodes/stats.json
  # GET /episodes/stats.xml
  def stats
    Project.find(42).hit
    @stats = time_data Episode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: time_data(Episode.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Episode.all, :hash) }
    end
  end

end
