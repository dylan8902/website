class FacebookPostsController < ApplicationController
  include Statistics
  
  
  # GET /facebook
  # GET /facebook.json
  # GET /facebook.xml
  def index
    @facebook_posts = FacebookPost.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facebook_posts, callback: params[:callback] }
      format.xml { render xml: @facebook_posts }
      format.rss { render 'feed' }
    end
  end


  # GET /facebook/all
  # GET /facebook/all.json
  # GET /facebook/all.xml
  def all
    @page[:per_page] = FacebookPost.count
    @facebook_posts = FacebookPost.paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @facebook_posts, callback: params[:callback] }
      format.xml { render xml: @facebook_posts }
      format.rss { render 'feed' }
    end
  end


  # GET /facebook/1
  # GET /facebook/1.json
  # GET /facebook/1.xml
  def show
    @facebook_post = FacebookPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @facebook_post, callback: params[:callback] }
      format.xml { render xml: @facebook_post }
    end
  end

  
  # GET /facebook/stats
  # GET /facebook/stats.json
  # GET /facebook/stats.xml
  def stats
   @stats = time_data FacebookPost.all
   @cloud = word_cloud FacebookPost.pluck(:text)
    
    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(FacebookPost.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(FacebookPost.all, :hash) }
    end
  end


  # GET /facebook/map
  # GET /facebook/map.json
  # GET /facebook/map.xml
  def map
    #Project.find(9).hit
    @locations = FacebookPost.where("lat IS NOT NULL AND lng IS NOT NULL")
    
    respond_to do |format|
      format.html # map.html.erb
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end
end
