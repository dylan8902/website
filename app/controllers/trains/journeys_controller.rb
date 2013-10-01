require 'will_paginate/array'

class Trains::JourneysController < ApplicationController
  before_filter :authenticate_user!

  # GET /trains/journeys
  # GET /trains/journeys.json
  # GET /trains/journeys.xml
  def index
    
    @journeys = Trains::Journey.where(user_id: current_user.id).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @journeys, callback: params[:callback] }
      format.xml { render xml: @journeys }
    end
  end

  # GET /trains/journeys/new
  # GET /trains/journeys/new.json
  # GET /trains/journeys/new.xml
  def new
    @journey = Trains::Journey.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @journey, callback: params[:callback] }
      format.xml { render xml: @journey }
    end
  end

  # GET /accounts/1/edit
  def edit
    @journey = Trains::Journey.where(user_id: current_user.id, id: params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @journey = Trains::Journey.new(params[:journey].merge!(user_id: current_user.id))

    respond_to do |format|
      if @journey.save
        format.html { redirect_to @journey, notice: 'Journey was successfully created.' }
        format.json { render json: @journey, status: :created, location: @journey }
        format.xml { render xml: @journey, status: :created, location: @journey }
      else
        format.html { render action: "new" }
        format.json { render json: @journey.errors, status: :unprocessable_entity }
        format.xml { render xml: @journey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
        format.xml { render xml: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  # DELETE /accounts/1.xml
  def destroy
    @journey = Trains::Journey.where(user_id: current_user.id, id: params[:id])
    @journey.destroy

    respond_to do |format|
      format.html { redirect_to trains_journeys_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end

end
