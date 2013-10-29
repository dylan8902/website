require 'will_paginate/array'

class Trains::JourneyLegsController < ApplicationController
  before_filter :authenticate_user!


  # GET /trains/journey/1/legs/1
  # GET /trains/journey/1/legs/1.json
  # GET /trains/journey/1/legs/1.xml
  def show
    @journey_leg = Trains::JourneyLeg.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @journey_leg, callback: params[:callback] }
      format.xml { render xml: @journey_leg }
    end
  end


  # GET /trains/journeys/1/legs/new
  # GET /trains/journeys/1/legs/new.json
  # GET /trains/journeys/1/legs/new.xml
  def new
    @journey = Trains::Journey.find(params[:journey_id])
    @journey_leg = Trains::JourneyLeg.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @journey_leg, callback: params[:callback] }
      format.xml { render xml: @journey_leg }
    end
  end


  # GET /trains/journey/1/legs/1/edit
  def edit
    @journey_leg = Trains::JourneyLeg.where(user_id: current_user.id, id: params[:id])
  end


  # POST /trains/journey/1/legs
  # POST /trains/journey/1/legs.json
  # POST /trains/journey/1/legs.xml
  def create
    @journey = Trains::Journey.find(params[:journey_id])
    @journey_leg = Trains::JourneyLeg.new(journey_leg_params.merge(journey_id: @journey.id))

    respond_to do |format|
      if @journey_leg.save
        format.html { redirect_to @journey, notice: 'Journey leg was successfully created.' }
        format.json { render json: @journey, status: :created, location: @journey }
        format.xml { render xml: @journey, status: :created, location: @journey }
      else
        format.html { render action: "new" }
        format.json { render json: @journey_leg.errors, status: :unprocessable_entity }
        format.xml { render xml: @journey_leg.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /trains/journey/1/leg/1
  # DELETE /trains.journey/1/leg/1.json
  # DELETE /trains/journey/1/leg/1.xml
  def destroy
    @journey_leg = Trains::JourneyLeg.where(user_id: current_user.id, id: params[:id])
    @journey_leg.destroy

    respond_to do |format|
      format.html { redirect_to trains_journeys_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def journey_leg_params
      params.require(:trains_journey_leg).permit(:departure_crs, :arrival_crs)
    end
    
    def trains_journey_leg_url
      "#{train_journeys_path}/#{self.journey.id}/legs/#{self.id}"
    end

end
