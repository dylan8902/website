class PubThursdayAuditController < ApplicationController
  include ErrorHelper

  FILENAME = Rails.root.join("json", "pub-thursday-audit.json")


  # GET /pub-thursday-audit
  # GET /pub-thursday-audit.json
  # GET /pub-thursday-audit.xml
  def index
    if File.exist?(FILENAME) and params[:refresh].nil?
      @users = load_users
    else
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

      4.times do
        next_page = "#{url}&pageToken=#{response["nextPageToken"]}"
        response = JSON.parse(RestClient.get(next_page).body)
        documents.concat response["documents"]
      end

      documents.each do |session|
        ref = session["fields"]["userRef"]["referenceValue"]
        start_time = DateTime.parse(session["fields"]["startTime"]["timestampValue"])
        end_time = DateTime.parse(session["fields"]["endTime"]["timestampValue"])
        location = session["fields"]["locationName"]["stringValue"]
        @users[ref][:sessions] << {
          id: session["name"].split('/').last,
          url: "#{api_url}#{session["name"]}",
          start: start_time,
          end: end_time,
          duration: TimeDifference.between(start_time, end_time).humanize,
          location: location
        }
      end

      @users = @users.values

      @users.delete_if do |user|
        user[:sessions].empty?
      end

      @users.each do |user|
        user[:sessions].each do |session|
          user[:sessions].each do |other_session|
            if
              (other_session[:start] > session[:start] and other_session[:end] < session[:end]) ||
              (other_session[:start] < session[:start] and other_session[:end] > session[:end]) ||
              (other_session[:start] > session[:start] and other_session[:start] < session[:end] and other_session[:end] > session[:end]) ||
              (other_session[:start] < session[:start] and other_session[:end] < session[:end] and other_session[:end] > session[:start])
              session[:within] = Marshal.load(Marshal.dump(other_session))
              session[:within][:longer] = (other_session[:end] - other_session[:start]) > (session[:end] - session[:start])
              user[:illegal] = true
            end
          end
        end

        user[:sessions].delete_if do |session|
          session[:within].nil?
        end
      end

      @users.delete_if do |user|
        user[:illegal].nil?
      end

      begin
        File.open(FILENAME, "w") do |f|
          f.write(@users.to_json)
        end
        File.open("#{FILENAME}.#{DateTime.now.iso8601}", "w") do |f|
          f.write(@users.to_json)
        end
      rescue SystemStackError => e
        puts e.inspect
      end
    end

    @worst_offenders = []
    @users.each do |user|
      hours = user[:sessions].map { |session| session[:end].to_i - session[:start].to_i }.sum.to_f / 60 / 60
      @worst_offenders << { user: user.except(:sessions), number: user[:sessions].length, hours: hours.round(2)  }
    end

    @worst_offenders.sort! { |a, b| b[:hours] <=> a[:hours] }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @worst_offenders, callback: params[:callback] }
      format.xml { render xml: @worst_offenders }
    end
  end


  # GET /pub-thursday-audit/session-id
  # GET /pub-thursday-audit/session-id.json
  # GET /pub-thursday-audit/session-id.xml
  def show
    @session = find_session params[:id]

    respond_to do |format|
      format.html # session.html.erb
      format.json { render json: @session, callback: params[:callback] }
      format.xml { render xml: @session }
    end
  end


  # POST /pub-thursday-audit/session-id
  # POST /pub-thursday-audit/session-id.json
  # POST /pub-thursday-audit/session-id.xml
  def delete
    @session = find_session params[:id]

    respond_to do |format|
      format.html # delete.html.erb
      format.json { render json: @session, callback: params[:callback] }
      format.xml { render xml: @session }
    end
  end


  def load_users
    users = JSON.load(FILENAME, nil, { symbolize_names: true, create_additions: nil })
    # Fix timestamps
    users.each do |user|
      user[:sessions].each do |session|
        session[:start] = DateTime.parse(session[:start])
        session[:end] = DateTime.parse(session[:end])
        if session[:within]
          session[:within][:start] = DateTime.parse(session[:within][:start])
          session[:within][:end] = DateTime.parse(session[:within][:end])
        end
      end
    end

    return users
  end

  def find_session id
    load_users.each do |user|
      user[:sessions].each do |session|
        if session[:id] == id
          return session
        end
      end
    end

    render_404
  end

end
