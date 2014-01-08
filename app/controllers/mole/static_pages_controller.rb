require 'rest_client'
class Mole::StaticPagesController < ApplicationController


  # GET /mole
  def index
    Project.hit 51
    @high_scores = Mole::HighScore.limit(3)

    respond_to do |format|
      format.html # index.html.erb
    end
  end


  # GET /mole/privacy
  def privacy

    respond_to do |format|
      format.html # privacy.html.erb
    end
  end


  # GET /mole/facebook
  def facebook
    Project.hit 51
    render layout: '../mole/static_pages/facebook'
  end


  # GET /mole/total
  # GET /mole/total.json
  # GET /mole/total.xml
  def total
    begin
      response = RestClient.get "https://api.justgiving.com/#{ENV['JUSTGIVING_API_KEY']}/v1/fundraising/pages/thebteam-cardiff"
      if response.code == 200
        @total = JSON.parse response.body
      end
    rescue => e
      logger.error "Mole Total: #{e.message}"
      @total = { grandTotalRaisedExcludingGiftAid: "Sorry, JustGiving is unavailable at this time." }
    end

    respond_to do |format|
      format.html # total.html.erb
      format.json { render json: @total, callback: params[:callback] }
      format.xml { render xml: @total }
    end
  end

end