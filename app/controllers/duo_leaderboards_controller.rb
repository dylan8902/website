class DuoLeaderboardsController < ApplicationController

  # GET /duo-leaderboards
  # GET /duo-leaderboards.json
  # GET /duo-leaderboards.xml
  def index
    @leaderboard = DuoLeaderboard.new
    limit = params[:limit] || DuoLeaderboard.count
    @page = { page: params[:page], per_page: limit.to_i }
    @order = params[:order] || "name"

    @leaderboards = DuoLeaderboard.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leaderboards, callback: params[:callback] }
      format.xml { render xml: @leaderboards }
      format.rss { render 'feed' }
    end
  end


  # GET /duo-leaderboards/all
  # GET /duo-leaderboards/all.json
  # GET /duo-leaderboards/all.xml
  def all
    @leaderboard = DuoLeaderboard.new
    @page[:per_page] = DuoLeaderboard.count
    @leaderboards = DuoLeaderboard.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @leaderboards, callback: params[:callback] }
      format.xml { render xml: @leaderboards }
      format.rss { render 'feed' }
    end
  end


  # GET /duo-leaderboards/new
  # GET /duo-leaderboards/new.json
  # GET /duo-leaderboards/new.xml
  def new
    @leaderboard = DuoLeaderboard.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leaderboard, callback: params[:callback] }
      format.xml { render xml: @leaderboard }
    end
  end


  # GET /duo-leaderboards/1/edit
  def show
    @leaderboard = DuoLeaderboard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @leaderboard, callback: params[:callback] }
      format.xml { render xml: @leaderboard }
    end
  end


  # GET /duo-leaderboards/1/edit
  def edit
    @leaderboard = DuoLeaderboard.find(params[:id])
  end


  # POST /duo-leaderboards
  # POST /duo-leaderboards.json
  def create
    @leaderboard = DuoLeaderboard.new(leaderboard_params)

    respond_to do |format|
      if @leaderboard.save
        format.html { redirect_to duo_leaderboards_path, notice: 'Leaderboard was successfully created.' }
        format.json { render json: @leaderboard, status: :created, location: @leaderboard }
      else
        format.html { render action: "new" }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /duo-leaderboards/1
  # PUT /duo-leaderboards/1.json
  def update
    @leaderboard = DuoLeaderboard.find(params[:id])

    respond_to do |format|
      if @leaderboard.update(leaderboard_params)
        format.html { redirect_to @leaderboard, notice: 'Leaderboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end


  # POST /duo-leaderboards/1/participants
  # POST /duo-leaderboards/1/participants.json
  def add_participant
    @leaderboard = DuoLeaderboard.find(params[:id])
    @participant = DuoParticipant.get(params[:participant])

    respond_to do |format|
      if @leaderboard.duo_participants.append(@participant)
        format.html { redirect_to @leaderboard, notice: 'Leaderboard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @leaderboard.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /duo-leaderboards/1
  # DELETE /duo-leaderboards/1.json
  # DELETE /duo-leaderboards/1.xml
  def destroy
    @leaderboard = DuoLeaderboard.find(params[:id])
    @leaderboard.destroy

    respond_to do |format|
      format.html { redirect_to leaderboards_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def leaderboard_params
      params.require(:duo_leaderboard).permit(:name, :url)
    end

end
