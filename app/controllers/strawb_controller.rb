class StrawbController < ApplicationController
  skip_before_action :verify_authenticity_token


  # GET /strawb
  # GET /strawb.json
  # GET /strawb.xml
  # POST /strawb
  # POST /strawb.json
  # POST /strawb.xml
  def index
    if params[:text].nil?
      response = get_strawb()
    elsif params[:text].downcase.include?("strawb")
      response = get_strawb()
    elsif params[:text].downcase.include?("weather")
      response = get_weather()
    elsif params[:text].downcase.include?("random")
      response = get_random()
    elsif params[:text].downcase.include?("pub thursday")
      response = get_pub_thursday()
    elsif params[:text].downcase.include?("test image")
      response = get_test_image()
    elsif params[:text].downcase.include?("help")
      response = get_help()
    else
      response = get_strawb()
    end

    respond_to do |format|
      format.html { render json: response, callback: params[:callback] }
      format.json { render json: response, callback: params[:callback] }
      format.xml { render xml: response}
    end
  end


  def get_strawb
    return {
      "type": "message",
      "text": "Stawbed Ya",
      "attachments": [
        {
          "contentType": "application/vnd.microsoft.card.hero",
          "content": {
            "title": "Strawbed Ya",
            "subtitle": "I have strawbed ya",
            "images": [
              {
                "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/PerfectStrawberry.jpg/220px-PerfectStrawberry.jpg"
              }
            ],
            "buttons": [
              {
                "type": "openUrl",
                "title": "I love strawberries",
                "value": "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/PerfectStrawberry.jpg/220px-PerfectStrawberry.jpg"
              }
            ]
          }
        }
      ]
    }
  end


  def get_weather
    url = "http://api.apixu.com/v1/current.json?key=36d5595b757c4ce4ab653726172505&q=cardiff"
    begin
      response = RestClient.get url
      weather = JSON.parse response.body
      return {
        "type": "message",
        "text": "It is #{weather['current']['condition']['text']}, #{weather['current']['temp_c']}°C"
      }
    rescue Exception => e
      logger.error "#{Time.now} Could get weather: #{e.message}"
    end
    return {
      "type": "message",
      "text": "Not quite sure at the moment, why not look outside?"
    }
  end


  def get_random
    return {
      "type": "message",
      "text": rand(0..10000).to_s
    }
  end


  def get_pub_thursday
    leaderboard = []
    begin
      response = RestClient.get 'http://52.49.119.75:8080/api/people'
      people = JSON.parse response.body
      people.each do |person|
        leaderboard << {
          "title" => person['name'],
          "type" => person['status'],
          "value" => "1"
        }
      end
    rescue Exception => e
      logger.error "#{Time.now} Could not pub thursday leaderboard: #{e.message}"
    end

    return {
      "type": "message",
      "attachmentLayout": "list",
      "text": "",
      "attachments": [
        {
          "contentType": "application/vnd.microsoft.card.hero",
          "content": {
            "text": "Pub Thursday Leaderboard",
            "buttons": leaderboard
          }
        }
      ]
    }
  end


  def get_help
    return {
      "type": "message",
      "text": "Hello! Why not try asking for the weather, or a random number, or a strawbbery or even the pub thursday leaderboard?"
    }
  end


  def get_test_image
    time = Time.now.to_i
    return {
      "type": "message",
      "text": "Test Image at #{time}",
      "attachments": [
        {
          "contentType": "application/vnd.microsoft.card.hero",
          "content": {
            "title": "Test Image",
            "subtitle": "Does the client get the image?",
            "images": [
              {
                "url": "http://dev.dyl.anjon.es:3000/images/project57.png?#{time}"
              }
            ]
          }
        }
      ]
    }
  end

end
