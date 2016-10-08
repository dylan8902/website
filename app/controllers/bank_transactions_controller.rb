class BankTransactionsController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!
  before_action :authenticate_admin!


  # GET /bank
  # GET /bank.json
  # GET /bank.xml
  def index
    @bank_transactions = BankTransaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_transactions, methods: :balance, callback: params[:callback] }
      format.xml { render xml: @bank_transactions, methods: :balance }
    end
  end


  # POST /bank
  # POST /bank.json
  # POST /bank.xml
  def create
    @bank_transactions = []

    lines = Base64.decode64 params[:file].sub('data:text/csv;base64,','')
    transactions = lines.split("\n").reverse

    transactions.each do |transaction|
      transaction = transaction.split(",")
      time = DateTime.strptime(transaction[0], '%Y-%m-%d')
      puts transaction[0]
      @bank_transactions <<  BankTransaction.create(description: transaction[1], amount: transaction[2], created_at: time, updated_at: time)
    end

    respond_to do |format|
      format.html
      format.json { render json: @bank_transactions, callback: params[:callback] }
      format.xml { render xml: @bank_transactions }
    end
  end

end
