class OauthClientsController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!
  before_action :authenticate_admin!


  # GET /oauth
  # GET /oauth.json
  # GET /oauth.xml
  def index
    @oauth_client = OauthClient.new
    limit = params[:limit] || OauthClient.count
    @page = { page: params[:page], per_page: limit.to_i }
    @order = params[:order] || "name"

    @oauth_clients = OauthClient.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @oauth_clients, callback: params[:callback] }
      format.xml { render xml: @oauth_clients }
      format.rss { render 'feed' }
    end
  end


  # GET /oauth/all
  # GET /oauth/all.json
  # GET /oauth/all.xml
  def all
    @oauth_client = OauthClient.new
    @page[:per_page] = OauthClient.count
    @oauth_clients = OauthClient.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @oauth_clients, callback: params[:callback] }
      format.xml { render xml: @oauth_clients }
      format.rss { render 'feed' }
    end
  end


  # GET /oauth/1
  def show
    @oauth_client = OauthClient.find(params[:id])
  end


  # POST /oauth
  # POST /oauth.json
  def create
    @oauth_client = OauthClient.new(oauth_client_params)

    respond_to do |format|
      if @oauth_client.save
        format.html { redirect_to oauth_clients_path, notice: 'OAuth client was successfully created.' }
        format.json { render json: @oauth_client, status: :created, location: @oauth_client }
      else
        format.html { render action: "new" }
        format.json { render json: @oauth_client.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /oauth/1
  # PUT /oauth/1.json
  def update
    @oauth_client = OauthClient.find(params[:id])

    respond_to do |format|
      if @oauth_client.update(oauth_client_params)
        format.html { redirect_to oauth_clients_path, notice: 'OAuth client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @oauth_client.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /oauth/1
  # DELETE /oauth/1.json
  # DELETE /oauth/1.xml
  def destroy
    @oauth_client = OauthClient.find(params[:id])
    @oauth_client.destroy

    respond_to do |format|
      format.html { redirect_to oauth_clients_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  # GET /oauth/authorise/1
  # GET /oauth/authorise/1.json
  def authorise
    @oauth_client = OauthClient.find(params[:id])

    response = @oauth_client.exchange(params[:code], request.original_url) if params[:code]
    @oauth_client.access_token = response["access_token"]
    @oauth_client.refresh_token = response["refresh_token"]
    @oauth_client.expires_at = response["expires_at"]

    respond_to do |format|
      if @oauth_client.save
        format.html { redirect_to oauth_client_path(@oauth_client), notice: 'OAuth client was successfully authorised.' }
        format.json { head :no_content }
      else
        format.html { render action: "show", error: 'OAuth client was not successfully authorised.' }
        format.json { render json: @oauth_client.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def oauth_client_params
      params.require(:oauth_client).permit(
        :name,
        :client_id,
        :client_secret,
        :token_url,
        :authorise_url,
        :scope,
        :response_type,
        :refresh_token,
        :access_token,
        :expires_at
      )
    end

end
