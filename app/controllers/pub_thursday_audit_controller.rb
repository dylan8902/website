class PubThursdayAuditController < ApplicationController
  include ErrorHelper

  FILENAME = Rails.root.join("json", "pub-thursday-audit.json")
  PROJECT = "pub-tracker-live"
  API_URL = "https://firestore.googleapis.com/v1/"
  DOCUMENT_ROOT = "projects/#{PROJECT}/databases/(default)/documents"
  BASE_URL = "#{API_URL}#{DOCUMENT_ROOT}"


  # GET /pub-thursday-audit
  # GET /pub-thursday-audit.json
  # GET /pub-thursday-audit.xml
  def index
    if File.exist?(FILENAME) and params[:refresh].nil?
      @users = load_users
    else
      @users = {}

      response = JSON.parse(RestClient.get("#{BASE_URL}/users?mask.fieldPaths=displayName&mask.fieldPaths=photoURL&pageSize=300").body)
      response["documents"].each do |user|
        display_name = user["fields"]["displayName"]["stringValue"]
        photo_url = user["fields"]["photoURL"]["stringValue"]
        @users[user["name"]] = { id: user["name"].split("/").last, name: display_name, photo: photo_url, sessions: [] }
      end

      documents = []

      url = "#{BASE_URL}/sessions?orderBy=startTime%20desc&mask.fieldPaths=startTime&mask.fieldPaths=endTime&mask.fieldPaths=userRef&mask.fieldPaths=locationName&mask.fieldPaths=time&pageSize=300"
      response = JSON.parse(RestClient.get(url).body)
      documents.concat response["documents"]

      4.times do
        next_page = "#{url}&pageToken=#{response["nextPageToken"]}"
        response = JSON.parse(RestClient.get(next_page).body)
        documents.concat response["documents"]
      end

      documents.each do |session|
        logger.info session
        ref = session["fields"]["userRef"]["referenceValue"]
        start_time = DateTime.parse(session["fields"]["startTime"]["timestampValue"])
        end_time = DateTime.parse(session["fields"]["endTime"]["timestampValue"])
        time = (session["fields"]["time"] || {} )["doubleValue"]
        location = session["fields"]["locationName"]["stringValue"]
        @users[ref][:sessions] << {
          id: session["name"].split('/').last,
          url: "#{API_URL}#{session["name"]}",
          start: start_time,
          end: end_time,
          time: time,
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
              session[:fixed] = session[:time] == 0
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
    @timestamps = timestamps @session

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
    @timestamps = timestamps @session

    @response = JSON.parse(RestClient.get("#{BASE_URL}/sessions/#{@session[:id]}").body)

    if (@response["fields"]["time"] || {})["doubleValue"] != 0
      field_transforms = []
      @timestamps.each do |k, v|
        field_transforms.push({
          increment: {
            "#{v.instance_of?(Integer) ? "integerValue" : "doubleValue"}": v
          },
          fieldPath: k
        })
      end

      transform = {
        writes: [
          {
            transform: {
              document: "#{DOCUMENT_ROOT}/users/#{@session[:user][:id]}",
              fieldTransforms: field_transforms
            }
          }
        ]
      }
      url = "#{BASE_URL}:commit"
      logger.info "Transforming user #{@session[:user]} - #{url} with #{transform.to_json}"
      RestClient.post(url, transform.to_json, content_type: :json)

      zero_time = {
        fields: {
          time: {
            doubleValue: 0
          }
        }
      }
      url = "#{BASE_URL}/sessions/#{@session[:id]}?updateMask.fieldPaths=time&currentDocument.exists=true"
      logger.info "Zero-ing session time #{@session[:id]} - #{url} with #{zero_time.to_json}"
      RestClient.patch(url, zero_time.to_json, content_type: :json)
    else
      logger.info "Session already fixed #{@session}"
    end

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
          session[:user] = user.except(:sessions)
          return session
        end
      end
    end

    render_404
  end

  def timestamps session
    ms = -(session[:end].strftime("%Q").to_i - session[:start].strftime("%Q").to_i)
    seconds = ms / 1000.to_f
    return {
      "#{session[:start].strftime('T%Y')}": ms,
      "#{session[:start].strftime('T%YM%m')}": ms,
      "#{session[:start].strftime('T%YW%V')}": ms,
      "Ttotal": ms,
      "yearTime": seconds,
      "totalTime": seconds
    }
  end

end
