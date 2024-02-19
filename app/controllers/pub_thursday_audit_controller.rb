class PubThursdayAuditController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!, except: [:index, :show, :all]
  before_action :authenticate_admin!, except: [:index, :show, :all]


  # GET /pub-thursday-audit
  # GET /pub-thursday-audit.json
  # GET /pub-thursday-audit.xml
  def index

    @users = {}
    project = "pub-tracker-live"
    base_url = "https://firestore.googleapis.com/v1/projects/#{project}/databases/(default)/documents"
    response = JSON.parse(RestClient.get("#{base_url}/users?mask.fieldPaths=displayName&pageSize=300").body)
    response["documents"].each do |user|
      display_name = user["fields"]["displayName"]["stringValue"]
      @users[user["name"]] = { name: display_name, sessions: [] }
    end

    documents = []

    url = "#{base_url}/sessions?orderBy=startTime%20desc&mask.fieldPaths=startTime&mask.fieldPaths=endTime&mask.fieldPaths=userRef&mask.fieldPaths=locationRef&pageSize=300"
    response = JSON.parse(RestClient.get(url).body)
    documents.concat response["documents"]

    url = "#{url}&pageToken=#{response["nextPageToken"]}"
    response = JSON.parse(RestClient.get(url).body)
    documents.concat response["documents"]

    documents.each do |session|
      ref = session["fields"]["userRef"]["referenceValue"]
      start_time = session["fields"]["startTime"]["timestampValue"]
      end_time = session["fields"]["endTime"]["timestampValue"]
      @users[ref][:sessions] << { id: session["name"], start: DateTime.parse(start_time), end: DateTime.parse(end_time) }
    end

    @users.delete_if do |k,v|
      v[:sessions].empty?
    end

    @users.each do |key, user|
      user[:sessions].each do |session|
        user[:sessions].each do |other_session|
          if other_session[:start] > session[:start] and other_session[:end] < session[:end]
            session[:within] = other_session
          end
        end
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users, callback: params[:callback] }
      format.xml { render xml: @users }
    end
  end
end