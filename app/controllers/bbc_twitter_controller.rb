class BbcTwitterController < ApplicationController
  
  # GET /bbc-twitter
  # GET /bbc-twitter.json
  # GET /bbc-twitter.xml
  def index
    
    @latest = BbcTwitter.latest
    @most = BbcTwitter.order("count DESC").limit(5)    
    @graph = Array.new
    BbcTwitter.all.each do |story|
      @graph << story.count
    end
    @count = BbcTwitter.sum('count')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @latest, callback: params[:callback] }
      format.xml { render xml: @latest }
    end
  end

end
