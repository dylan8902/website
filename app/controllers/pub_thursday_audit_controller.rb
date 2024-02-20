class PubThursdayAuditController < ApplicationController
  include ErrorHelper


  # GET /pub-thursday-audit
  # GET /pub-thursday-audit.json
  # GET /pub-thursday-audit.xml
  def index

    project = "pub-tracker-live"
    api_url = "https://firestore.googleapis.com/v1/"
    base_url = "#{api_url}projects/#{project}/databases/(default)/documents"

    @users = {}

    response = JSON.parse(RestClient.get("#{base_url}/users?mask.fieldPaths=displayName&mask.fieldPaths=photoURL&pageSize=300").body)
    response["documents"].each do |user|
      display_name = user["fields"]["displayName"]["stringValue"]
      photo_url = user["fields"]["photoURL"]["stringValue"]
      @users[user["name"]] = { name: display_name, photo: photo_url, sessions: [] }
    end

    documents = []

    url = "#{base_url}/sessions?orderBy=startTime%20desc&mask.fieldPaths=startTime&mask.fieldPaths=endTime&mask.fieldPaths=userRef&mask.fieldPaths=locationName&pageSize=300"
    response = JSON.parse(RestClient.get(url).body)
    documents.concat response["documents"]

    next_page = "#{url}&pageToken=#{response["nextPageToken"]}"
    response = JSON.parse(RestClient.get(next_page).body)
    documents.concat response["documents"]

    next_page = "#{url}&pageToken=#{response["nextPageToken"]}"
    response = JSON.parse(RestClient.get(next_page).body)
    documents.concat response["documents"]

    next_page = "#{url}&pageToken=#{response["nextPageToken"]}"
    response = JSON.parse(RestClient.get(next_page).body)
    documents.concat response["documents"]

    documents.each do |session|
      ref = session["fields"]["userRef"]["referenceValue"]
      start_time = session["fields"]["startTime"]["timestampValue"]
      end_time = session["fields"]["endTime"]["timestampValue"]
      location = session["fields"]["locationName"]["stringValue"]
      @users[ref][:sessions] << {
        id: session["name"],
        url: "#{api_url}#{session["name"]}",
        start: DateTime.parse(start_time),
        end: DateTime.parse(end_time),
        location: location
      }
    end

    @users.delete_if do |k,v|
      v[:sessions].empty?
    end

    @users.each do |key, user|
      user[:sessions].each do |session|
        user[:sessions].each do |other_session|
          if
            (other_session[:start] > session[:start] and other_session[:end] < session[:end]) ||
            (other_session[:start] < session[:start] and other_session[:end] > session[:end]) ||
            (other_session[:start] > session[:start] and other_session[:start] < session[:end] and other_session[:end] > session[:end]) ||
            (other_session[:start] < session[:start] and other_session[:end] < session[:end] and other_session[:end] > session[:start])
            session[:within] = {
              id: other_session[:id],
              url: other_session[:url],
              start: other_session[:start],
              end: other_session[:end]
            }
            user[:illegal] = true
          end
        end
      end
      user[:sessions].delete_if do |session|
        session[:within].nil?
      end
    end

    @users.delete_if do |k,v|
      v[:illegal].nil?
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users, callback: params[:callback] }
      format.xml { render xml: @users }
    end
  end
end