class RunningEventsController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  after_action :analytics


  # GET /running
  # GET /running.json
  # GET /running.xml
  def index
    @running_events = RunningEvent.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @running_events, callback: params[:callback] }
      format.xml { render xml: @running_events }
    end
  end


  # GET /running/all
  # GET /running/all.json
  # GET /running/all.xml
  def all
    @page[:per_page] = RunningEvent.count
    @running_events = RunningEvent.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @running_events, callback: params[:callback] }
      format.xml { render xml: @running_events }
    end
  end


  # GET /running/1
  # GET /running/1.json
  # GET /running/1.xml
  def show
    @running_event = RunningEvent.find(params[:id])
    @locations = @running_event.points
    @zoom = "15"
    @pace = (@running_event.finish_time.to_f / 60) / (@running_event.distance.to_f / 1000)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @running_event, callback: params[:callback] }
      format.xml { render xml: @running_event }
    end
  end


  # GET /running/stats
  # GET /running/stats.json
  # GET /running/stats.xml
  def stats
    @stats = {
      total_distance: RunningEvent.sum(:distance),
      total_time: RunningEvent.sum(:finish_time),
      average_speed: (RunningEvent.sum(:finish_time).to_f / 60) / (RunningEvent.sum(:distance).to_f / 1000)
    }

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: @stats, callback: params[:callback] }
      format.xml { render xml: @stats }
    end
  end


  # GET /running/map
  # GET /running/map.json
  # GET /running/map.xml
  def map
    @locations = RunningEvent.where("lat IS NOT NULL AND lng IS NOT NULL")

    respond_to do |format|
      format.html # map.html.erb
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end


  # GET /running/new
  # GET /running/new.json
  # GET /running/new.xml
  def new
    @running_event = RunningEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @running_event, callback: params[:callback] }
      format.xml { render xml: @running_event }
    end
  end


  # GET /running/1/edit
  def edit
    @running_event = RunningEvent.find(params[:id])
  end


  # POST /running
  # POST /running.json
  def create
    @running_event = RunningEvent.new(running_event_params)

    respond_to do |format|
      if @running_event.save
        format.html { redirect_to running_event_path(@running_event), notice: 'Running event was successfully created.' }
        format.json { render json: @running_event, status: :created, location: @running_event }
      else
        format.html { render action: "new" }
        format.json { render json: @running_event.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /running/1
  # PUT /running/1.json
  def update
    @running_event = RunningEvent.find(params[:id])

    respond_to do |format|
      if @running_event.update(running_event_params)
        if @running_event.sport == "Run"
          format.html { redirect_to running_event_path(@running_event), notice: 'Running event was successfully updated.' }
        elsif @running_event.sport == "Ride"
          format.html { redirect_to cycling_event_path(@running_event), notice: 'Cycling event was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @running_event.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /running/1
  # DELETE /running/1.json
  # DELETE /running/1.xml
  def destroy
    @running_event = RunningEvent.find(params[:id])
    @running_event.destroy

    respond_to do |format|
      format.html { redirect_to running_events_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def running_event_params
      params.require(:running_event).permit(:name, :location, :lat, :lng, :training, :link, :distance, :finish_time, :position, :created_at, :sport)
    end

    def analytics
      Project.hit 55
    end

end
