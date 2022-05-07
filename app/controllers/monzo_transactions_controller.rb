class MonzoTransactionsController < ApplicationController
  include ErrorHelper
  include Statistics
  before_action :authenticate_user!
  before_action :authenticate_admin!


  # GET /monzo
  # GET /monzo.json
  # GET /monzo.xml
  def index
    limit = params[:limit] || MonzoTransaction.count
    @page = { page: params[:page], per_page: limit.to_i }
    @order = params[:order] || "created_at"

    @transactions = MonzoTransaction.order(@order).paginate(@page)
    @balance = MonzoTransaction.balance

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions, callback: params[:callback] }
      format.xml { render xml: @transactions }
      format.rss { render 'feed' }
    end
  end


  # GET /monzo/all
  # GET /monzo/all.json
  # GET /monzo/all.xml
  def all
    @page[:per_page] = MonzoTransaction.count
    @transactions = MonzoTransaction.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @transactions, callback: params[:callback] }
      format.xml { render xml: @transactions }
      format.rss { render 'feed' }
    end
  end


  # GET /monzo/1
  # GET /monzo/1.json
  # GET /monzo/1.xml
  def show
    @transaction = MonzoTransaction.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transaction, callback: params[:callback] }
      format.xml { render xml: @transaction }
    end
  end


  # GET /monzo/stats
  # GET /monzo/stats.json
  # GET /monzo/stats.xml
  def stats
    @stats = time_data MonzoTransaction.all

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(MonzoTransaction.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(MonzoTransaction.all, :hash) }
    end
  end


  # GET /monzo/map
  # GET /monzo/map.json
  # GET /monzo/map.xml
  def map
    @locations = MonzoTransaction.where("lat IS NOT NULL AND lng IS NOT NULL")

    respond_to do |format|
      format.html # map.html.erb
      format.json { render json: @locations, callback: params[:callback] }
      format.xml { render xml: @locations }
    end
  end

end
