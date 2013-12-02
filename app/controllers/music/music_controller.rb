require 'rest_client'
class Music::MusicController < ApplicationController

  # GET /music
  # GET /music.json
  def index
    Project.hit 33
    @listens = Listen.limit(12)
    @dj_events = DjEvent.limit(5)
    @gigs = Gig.limit(5)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: { listens: @listens, dj_events: @dj_events, gigs: @gigs }, :callback => params[:callback] }
      format.xml { render xml: { listens: @listens, dj_events: @dj_events, gigs: @gigs } }
    end
  end

end
