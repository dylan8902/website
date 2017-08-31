class Wedding::RsvpsController < ApplicationController
  include ErrorHelper
  layout "wedding"
  before_action :authenticate_user!, except: [:index, :create]
  before_action :authenticate_admin!, except: [:index, :create]


  # GET /wedding/rsvp
  # GET /wedding/rsvp.json
  # GET /wedding/rsvp.xml
  def index
    @rsvp = Wedding::Rsvp.new
    limit = params[:limit] || Wedding::Rsvp.count
    @page = { page: params[:page], per_page: limit.to_i }
    @order = params[:order] || "name"

    @rsvps = Wedding::Rsvp.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rsvps, callback: params[:callback] }
      format.xml { render xml: @rsvps }
      format.rss { render 'feed' }
    end
  end


  # GET /wedding/rsvp/1/edit
  def edit
    @rsvp = Wedding::Rsvp.find(params[:id])
  end


  # POST /wedding/rsvp
  # POST /wedding/rsvp.json
  def create
    @rsvp = Wedding::Rsvp.new(rsvp_params)

    respond_to do |format|
      if @rsvp.save
        format.html { redirect_to wedding_rsvp_index_path, notice: @rsvp }
        format.json { render json: @rsvp, status: :created, location: @rsvp }
      else
        format.html { render action: "index" }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /wedding/rsvp/1
  # PUT /wedding/rsvp/1.json
  def update
    @rsvp = Wedding::Rsvp.find(params[:id])

    respond_to do |format|
      if @rsvp.update_attributes(account_params)
        format.html { redirect_to wedding_rsvp_index_path, notice: 'RSVP was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /wedding/rsvp/1
  # DELETE /wedding/rsvp/1.json
  # DELETE /wedding/rsvp/1.xml
  def destroy
    @rsvp = Wedding::Rsvp.find(params[:id])
    @rsvp.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def rsvp_params
      params.require(:wedding_rsvp).permit(:name, :rsvp, :notes)
    end

end
