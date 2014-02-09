class EpisodesController < ApplicationController
  include Statistics
  include ErrorHelper
  before_filter :authenticate_user!, only: [:add]
  after_filter :episode_project_hit, only: [:index, :user, :all]
  after_filter :episode_stats_project_hit, only: [:stats, :user_stats]


  # GET /episodes
  # GET /episodes.json
  # GET /episodes.xml
  def index
    if current_user
      @episodes = current_user.episodes.paginate(@page)
    else
      @episodes = Episode.where(user_id: 1).paginate(@page)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @episodes, callback: params[:callback] }
      format.xml { render xml: @episodes }
      format.rss { render 'feed' }
    end
  end


  # GET /episodes/user/1
  # GET /episodes/user/1.json
  # GET /episodes/user/1.xml
  def user
    @user = User.find(params[:id])
    @episodes = @user.episodes.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @episodes, callback: params[:callback] }
      format.xml { render xml: @episodes }
      format.rss { render 'feed' }
    end
  end


  # GET /episodes/all
  # GET /episodes/all.json
  # GET /episodes/all.xml
  def all
    @page[:per_page] = Episode.count
    @episodes = Episode.paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @episodes, callback: params[:callback] }
      format.xml { render xml: @episodes }
      format.rss { render 'feed' }
    end
  end


  # GET /episodes/1
  # GET /episodes/1.json
  # GET /episodes/1.xml
  def show
    @episode = Episode.find_by_pid(params[:id]) or render_404 and return

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @episode, callback: params[:callback] }
      format.xml { render xml: @episode }
    end
  end


  # GET /episodes/users/1/stats
  # GET /episodes/users/1/stats.json
  # GET /episodes/users/1/stats.xml
  def user_stats
    @user = User.find(params[:id])
    @stats = time_data @user.episodes
    @cloud = word_cloud @user.episodes.pluck(:title)

    respond_to do |format|
      format.html { render 'stats' }
      format.json { render json: time_data(@user.episodes, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(@user.episodes, :hash) }
    end
  end


  # GET /episodes/stats
  # GET /episodes/stats.json
  # GET /episodes/stats.xml
  def stats
    @stats = time_data Episode.all
    @cloud = word_cloud Episode.pluck(:title)

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(Episode.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Episode.all, :hash) }
    end
  end


  # GET /episodes/add
  # GET /episodes/add.json
  # GET /episodes/add.xml
  def add
    unless params[:url].nil?
      @episode = Episode.add params[:url], current_user
    end

    respond_to do |format|
      format.html { render 'show' }
      format.json { render json: @episode, callback: params[:callback] }
      format.xml { render xml: @episode }
    end
  end


  private
    def episode_project_hit
      Project.hit 13
    end


    def episode_stats_project_hit
      Project.hit 42
    end


end
