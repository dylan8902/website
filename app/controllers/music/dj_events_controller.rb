class Music::DjEventsController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_admin!, except: [:index, :show]


  # GET /music/dj
  # GET /music/dj.json
  # GET /music/dj.xml
  def index
    Project.hit 19
    @dj_events = DjEvent.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dj_events, callback: params[:callback] }
      format.xml { render xml: @dj_events }
    end
  end


  # GET /music/dj/1
  # GET /music/dj/1.json
  # GET /music/dj/1.xml
  def show
    Project.hit 19
    @dj_event = DjEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dj_event, methods: [:dj_tracks], callback: params[:callback] }
      format.xml { render xml: @dj_event }
    end
  end


  # GET /music/dj/new
  # GET /music/dj/new.json
  # GET /music/dj/new.xml
  def new
    @dj_event = DjEvent.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dj_event, callback: params[:callback] }
      format.xml { render xml: @dj_event }
    end
  end


  # GET /music/dj/1/edit
  def edit
    @dj_event = DjEvent.find(params[:id])
  end


  # POST /music/dj
  # POST /music/dj.json
  def create
    @dj_event = DjEvent.new(params[:account])

    respond_to do |format|
      if @dj_event.save
        format.html { redirect_to @dj_event, notice: 'DJ Event was successfully created.' }
        format.json { render json: @dj_event, status: :created, location: @dj_event }
      else
        format.html { render action: "new" }
        format.json { render json: @dj_event.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /music/dj/1
  # PUT /music/dj/1.json
  def update
    @dj_event = DjEvent.find(params[:id])

    respond_to do |format|
      if @dj_event.update(params[:dj_event])
        format.html { redirect_to @dj_event, notice: 'Event post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dj_event.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /music/dj/1
  # DELETE /music/dj/1.json
  def destroy
    @dj_event = DjEvent.find(params[:id])
    @dj_event.destroy

    respond_to do |format|
      format.html { redirect_to music_dj_events_url }
      format.json { head :no_content }
    end
  end


end
