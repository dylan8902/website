class MonzoTransactionsController < ApplicationController
  include ErrorHelper
  include Statistics
  before_action :authenticate_user!, :except => [:webhook]
  before_action :authenticate_admin!, :except => [:webhook]
  skip_before_action :verify_authenticity_token, :only => [:webhook]


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


  # POST /monzo/webhook
  # POST /monzo/webhook.json
  # POST /monzo/webhook.xml
  def webhook
    @webhook = params
    logger.info "Webhook recieved, data: #{@webhook}"

    sweepstake = "euros-2024"
    emojis = ["⚽", "football"]

    begin
      if @webhook["type"] == "transaction.created" and emojis.include? @webhook["data"]["notes"].strip.downcase and @webhook["data"]["amount"] == 200
        logger.info "This is a #{sweepstake} payment"
        payee = @webhook["data"]["counterparty"]["name"]
        logger.info "from #{payee}"

        project = "pub-tracker-live"
        base_url = "https://firestore.googleapis.com/v1/projects/#{project}/databases/(default)/documents"
        response = JSON.parse(RestClient.get("#{base_url}/sweepstakes/#{sweepstake}").body)
        current_pot = response["fields"]["pot"].values[0].to_f
        match = nil
        response = JSON.parse(RestClient.get("#{base_url}/users?pageSize=100&mask.fieldPaths=displayName&mask.fieldPaths=photoURL").body)
        response["documents"].each do |user|
          account = {
            user: user["fields"]["displayName"]["stringValue"],
            userPhotoURL: user["fields"]["photoURL"]["stringValue"]
          }
          if account[:user].strip.downcase.eql? payee.strip.downcase
            logger.info("who is #{account}")
            match = account
          end
        end
        if match
          data = {
            "fields": {
              "user": { "stringValue": match[:user] },
              "userPhotoURL": { "stringValue": match[:userPhotoURL] }
            }
          }
        else
          data = {
            "fields": {
              "user": { "stringValue": payee },
              "userPhotoURL": { "stringValue": "/flags/Monzo.png" }
            }
          }
        end
        available_teams = []
        response = JSON.parse(RestClient.get("#{base_url}/sweepstakes/#{sweepstake}/teams?pageSize=100").body)
        response["documents"].each do |team|
          available_teams << team["name"] if team["fields"]["user"]["stringValue"] == "TBC"
        end
        if available_teams.length > 0
          url = "https://firestore.googleapis.com/v1/#{available_teams.sample.gsub(" ", "%20")}?updateMask.fieldPaths=user&updateMask.fieldPaths=userPhotoURL"
          response = RestClient.patch(url, data.to_json, content_type: :json)
          logger.info response.body
          data = {
            "fields": {
              "pot": { "doubleValue": current_pot + 2 },
            }
          }
          response = RestClient.patch("#{base_url}/sweepstakes/#{sweepstake}?updateMask.fieldPaths=pot", data.to_json, content_type: :json)
          logger.info response.body
        else
          logger.info "No teams left for #{payee}, they will need a refund"
        end
      else
        logger.info "This is not a #{sweepstake} payment"
        logger.info "#{@webhook["type"]} (#{@webhook["type"] == "transaction.created"})"
        logger.info "#{@webhook["data"]["notes"].strip.downcase} (#{emojis.include? @webhook["data"]["notes"].strip.downcase})"
        logger.info "#{@webhook["data"]["amount"]} (#{@webhook["data"]["amount"] == 200})"
      end
    rescue => e
      logger.info "Error: #{e.message}"
    end

    respond_to do |format|
      format.html # webook.html.erb
      format.json { render json: @webhook, callback: params[:callback] }
      format.xml { render xml: @webhook }
    end
  end

end
