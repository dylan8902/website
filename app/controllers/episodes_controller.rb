class EpisodesController < ApplicationController
  include Statistics
  
  # GET /episodes
  # GET /episodes.json
  # GET /episodes.xml
  def index
    Project.hit 13
    @episodes = Episode.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @episodes, callback: params[:callback] }
      format.xml { render xml: @episodes }
    end
  end


  # GET /episodes/all
  # GET /episodes/all.json
  # GET /episodes/all.xml
  def all
    Project.hit 13
    @page[:per_page] = Episode.count
    @episodes = Episode.paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @episodes, callback: params[:callback] }
      format.xml { render xml: @episodes }
    end
  end


  # GET /episodes/1
  # GET /episodes/1.json
  # GET /episodes/1.xml
  def show
    Project.hit 13
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
    Project.hit 42
    @stats = time_data Episode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: time_data(Episode.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Episode.all, :hash) }
    end
  end

end
