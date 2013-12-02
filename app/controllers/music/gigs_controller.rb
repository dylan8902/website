class Music::GigsController < ApplicationController


  # GET /music/gigs
  # GET /music/gigs.json
  # GET /music/gigs.xml
  def index
    @gigs = Gig.paginate(@page)

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

end
