class BbcTwitterController < ApplicationController
  include Statistics


  # GET /bbc-twitter
  # GET /bbc-twitter.json
  # GET /bbc-twitter.xml
  def index
    @latest = BbcTwitter.latest
    @most = BbcTwitter.order("count DESC").limit(5)
    @stats = time_data BbcTwitter.all
    @count = BbcTwitter.sum('count')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @latest, callback: params[:callback] }
      format.xml { render xml: @latest }
    end
  end


end