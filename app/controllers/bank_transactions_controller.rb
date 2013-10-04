class BankTransactionsController < ApplicationController
  include ErrorHelper
  before_filter :authenticate_user!
  before_filter :authenticate_admin!
  
  # GET /bank
  # GET /bank.json
  # GET /bank.xml
  def index
    @bank_transactions = BankTransaction.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_transactions, methods: :balance, callback: params[:callback] }
      format.xml { render xml: @bank_transactions, methods: :balance }
    end
  end

end
