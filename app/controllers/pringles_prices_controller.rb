class PringlesPricesController < ApplicationController
  include Statistics


  # GET /pringles
  # GET /pringles.json
  # GET /pringles.xml
  def index
    Project.hit 57
    @prices = [PringlesPrice.tesco.first, PringlesPrice.asda.first]
    @winner = PringlesPrice.winner
    @stats = PringlesPrice.stats

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prices, callback: params[:callback] }
      format.xml { render xml: @prices }
    end
  end

end