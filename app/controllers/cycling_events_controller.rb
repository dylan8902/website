class CyclingEventsController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  after_action :analytics


  # GET /cycling
  # GET /cycling.json
  # GET /cycling.xml
  def index
    @cycling_events = CyclingEvent.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cycling_events, callback: params[:callback] }
      format.xml { render xml: @cycling_events }
    end
  end


  # GET /cycling/all
  # GET /cycling/all.json
  # GET /cycling/all.xml
  def all
    @page[:per_page] = CyclingEvent.count
    @cycling_events = CyclingEvent.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @cycling_events, callback: params[:callback] }
      format.xml { render xml: @cycling_events }
    end
  end


  # GET /cycling/1
  # GET /cycling/1.json
  # GET /cycling/1.xml
  def show
    @cycling_event = CyclingEvent.find(params[:id])
    @locations = @cycling_event.points
    @zoom = "15"
    @pace = @cycling_event.distance.to_f / @cycling_event.finish_time.to_f

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cycling_event, callback: params[:callback] }
      format.xml { render xml: @cycling_event }
    end
  end


  # GET /cycling/stats
  # GET /cycling/stats.json
  # GET /cycling/stats.xml
  def stats
    @stats = {
      total_distance: CyclingEvent.sum(:distance),
      total_time: CyclingEvent.sum(:finish_time),
      average_speed: CyclingEvent.sum(:distance).to_f / CyclingEvent.sum(:finish_time).to_f
    }

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: @stats, callback: params[:callback] }
      format.xml { render xml: @stats }
    end
  end


  # GET /cycling/map
  # GET /cycling/map.json
  # GET /cycling/map.xml
  def map
    @locations = CyclingEvent.where("lat IS NOT NULL AND lng IS NOT NULL")

    respond_to do |format|
      format.html # map.html.erb
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end


  # GET /cycling/new
  # GET /cycling/new.json
  # GET /cycling/new.xml
  def new
    @cycling_event = CyclingEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cycling_event, callback: params[:callback] }
      format.xml { render xml: @cycling_event }
    end
  end


  # GET /cycling/1/edit
  def edit
    @cycling_event = CyclingEvent.find(params[:id])
  end


  # POST /cycling
  # POST /cycling.json
  def create
    @cycling_event = CyclingEvent.new(cycling_event_params)

    respond_to do |format|
      if @cycling_event.save
        format.html { redirect_to cycling_event_path(@cycling_event), notice: 'Cycling event was successfully created.' }
        format.json { render json: @cycling_event, status: :created, location: @cycling_event }
      else
        format.html { render action: "new" }
        format.json { render json: @cycling_event.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /cycling/1
  # PUT /cycling/1.json
  def update
    @cycling_event = CyclingEvent.find(params[:id])

    respond_to do |format|
      if @cycling_event.update(cycling_event_params)
        if @cycling_event.sport == "Run"
          format.html { redirect_to running_event_path(@cycling_event), notice: 'Running event was successfully updated.' }
        elsif @cycling_event.sport == "Ride"
          format.html { redirect_to cycling_event_path(@cycling_event), notice: 'Cycling event was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cycling_event.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /cycling/1
  # DELETE /cycling/1.json
  # DELETE /cycling/1.xml
  def destroy
    @cycling_event = CyclingEvent.find(params[:id])
    @cycling_event.destroy

    respond_to do |format|
      format.html { redirect_to cycling_events_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def cycling_event_params
      params.require(:cycling_event).permit(:name, :location, :lat, :lng, :training, :link, :distance, :finish_time, :position, :created_at, :sport)
    end

    def analytics
      Project.hit 63
    end

end
