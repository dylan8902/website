class PringlesPricesController < ApplicationController
  include Statistics


  # GET /pringles
  # GET /pringles.json
  # GET /pringles.xml
  def index
    Project.hit 57
    @tesco_price_today = PringlesPrice.tesco.first
    @asda_price_today = PringlesPrice.asda.first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pringles, callback: params[:callback] }
      format.xml { render xml: @pringles }
    end
  end

end
