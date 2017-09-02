class MonzoTransactionsController < ApplicationController
  include ErrorHelper
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
      format.html { render 'index.html.erb' }
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


end
