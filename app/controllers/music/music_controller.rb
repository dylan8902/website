require 'rest_client'
class Music::MusicController < ApplicationController

  # GET /music
  # GET /music.json
  def index
    Project.find(33).hit
    @listens = Listen.limit(12)
    @dj_events = DjEvent.limit(5)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plays, :callback => params[:callback] }
      format.xml { render xml: @plays }
    end
  end

end
