require 'will_paginate/array'
class Trains::JourneysController < ApplicationController
  before_filter :authenticate_user!, except: [:show]


  # GET /trains/journeys
  # GET /trains/journeys.json
  # GET /trains/journeys.xml
  def index
    @journeys = Trains::Journey.where(user_id: current_user.id).paginate(@page)
    @journey = Trains::Journey.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @journeys, callback: params[:callback] }
      format.xml { render xml: @journeys }
    end
  end


  # GET /trains/journey/1
  # GET /trains/journey/1.json
  # GET /trains/journey/1.xml
  def show
    @journey = Trains::Journey.find(params[:id])

    @og = {
      "og:title" => @journey,
      "og:type" => "train-track:train_journey",
      "og:url" => request.original_url,
      "og:image" => @journey.google_map_image,
      "og:site_name" => "dyl.anjon.es",
      "fb:app_id" => "272514462916508",
      "train-track:origin_station" => trains_location_url(@journey.origin),
      "train-track:destination_station" => trains_location_url(@journey.destination)
    }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @journey, methods: [:origin, :destination, :legs], callback: params[:callback] }
      format.xml { render xml: @journey, methods: [:origin, :destination, :legs] }
    end
  end


  # GET /trains/journey/1/edit
  def edit
    @journey = Trains::Journey.find(params[:id])
    render_403 and return if @journey.user_id != current_user.id
  end


  # POST /trains/journey
  # POST /trains/journey.json
  def create
    @journey = Trains::Journey.new(user_id: current_user.id)

    respond_to do |format|
      if @journey.save
        format.html { redirect_to new_trains_journey_journey_leg_path(@journey), notice: 'Journey was successfully created.' }
        format.json { render json: @journey, status: :created, location: new_trains_journey_journey_leg_path(@journey) }
        format.xml { render xml: @journey, status: :created, location: new_trains_journey_journey_leg_path(@journey) }
      else
        format.html { render action: "new" }
        format.json { render json: @journey.errors, status: :unprocessable_entity }
        format.xml { render xml: @journey.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /trains/journey/1
  # DELETE /trains.journey/1.json
  # DELETE /trains/journey/1.xml
  def destroy
    @journey = Trains::Journey.find(params[:id])
    render_404 and return if @journey.nil?
    render_403 and return if @journey.user_id != current_user.id
    @journey.destroy

    respond_to do |format|
      format.html { redirect_to trains_journeys_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end

end
