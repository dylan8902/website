class AccountsController < ApplicationController
  include ErrorHelper
  before_filter :authenticate_user!
  before_filter :authenticate_admin!


  # GET /accounts
  # GET /accounts.json
  # GET /accounts.xml
  def index
    
    @account = Account.new
    @accounts = Account.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts, callback: params[:callback] }
      format.xml { render xml: @accounts }
    end
  end


  # GET /accounts/all
  # GET /accounts/all.json
  # GET /accounts/all.xml
  def all

    @account = Account.new
    @page[:per_page] = Account.count
    @accounts = Account.paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @accounts, callback: params[:callback] }
      format.xml { render xml: @accounts }
    end
  end


  # GET /accounts/new
  # GET /accounts/new.json
  # GET /accounts/new.xml
  def new
    @account = Account.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @account, callback: params[:callback] }
      format.xml { render xml: @account }
    end
  end


  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end


  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_path, notice: 'account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(account_params)
        format.html { redirect_to accounts_path, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /accounts/1
  # DELETE /accounts/1.json
  # DELETE /accounts/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def account_params
      params.require(:account).permit(:name, :credential, :number)
    end
end
