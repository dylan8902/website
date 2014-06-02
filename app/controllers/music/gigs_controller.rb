class Music::GigsController < ApplicationController
  include Statistics


  # GET /music/gigs
  # GET /music/gigs.json
  # GET /music/gigs.xml
  def index
    @gigs = Gig.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gigs, callback: params[:callback] }
      format.xml { render xml: @gigs }
    end
  end


  # GET /music/gigs/1
  # GET /music/gigs/1.json
  # GET /music/gigs/1.xml
  def show
    @gig = Gig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gig, callback: params[:callback] }
      format.xml { render xml: @gig }
    end
  end


  # GET /music/gigs/stats
  # GET /music/gigs/stats.json
  # GET /music/gigs/stats.xml
  def stats
    @stats = time_data Gig.all

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(Gig.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Gig.all, :hash) }
    end
  end


  # GET /music/gigs/map
  # GET /music/gigs/map.json
  # GET /music/gigs/map.xml
  def map
    @locations = Gig.where("lat IS NOT NULL AND lng IS NOT NULL")

    respond_to do |format|
      format.html # map.html.erb
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end

end
