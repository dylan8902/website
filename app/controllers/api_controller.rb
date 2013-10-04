class ApiController < ApplicationController
  
  # GET /api
  # GET /api.json
  # GET /api.xml
  def index
    Project.hit 12

    @methods = [
      { url: "/api", description: "Returns API methods" },
      { url: "/blog", description: "Returns blog posts" },
      { url: "/episodes", description: "Returns iPlayer episodes I have watched" },
      { url: "/facebook", description: "Returns public Facebook posts I have made" },
      { url: "/photos", description: "Returns public photos from Flickr" },
      { url: "/tweets", description: "Returns public tweets from Twitter" },
      { url: "/locations", description: "Returns my location history" },
      { url: "/onradio", description: "Returns show and track information" },
      { url: "/iphone", description: "Returns location information stored in iPhone" },
      { url: "/browserwars", description: "Returns twitter information for major browsers" }
    ]
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @methods, callback: params[:callback] }
      format.xml { render xml: @methods }
    end
  end

end
