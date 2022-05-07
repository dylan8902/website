class Music::ListensController < ApplicationController
  include Statistics


  # GET /music/listens
  # GET /music/listens.json
  # GET /music/listens.xml
  def index
    @listens = Track.order(@order).paginate(@page)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @listens, callback: params[:callback] }
      format.xml { render xml: @listens }
    end
  end


  # GET /music/listens/1
  # GET /music/listens/1.json
  # GET /music/listens/1.xml
  def show
    @listen = Track.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @listen, callback: params[:callback] }
      format.xml { render xml: @listen }
    end
  end


  # GET /music/listens/all
  # GET /music/listens/all.json
  # GET /music/listens/all.xml
  def all
    @page[:per_page] = Track.count
    @listens = Track.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @listens, callback: params[:callback] }
      format.xml { render xml: @listens }
    end
  end


  # GET /music/listens/stats
  # GET /music/listens/stats.json
  # GET /music/listens/stats.xml
  def stats
    @stats = time_data Track.all
    @cloud = word_cloud Track.pluck(:artist), split: false, limit: 60

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(Track.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Track.all, :hash) }
    end
  end

end
