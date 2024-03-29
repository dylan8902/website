require 'digest/md5'
class PubThursdayController < ApplicationController
  skip_before_action :verify_authenticity_token

  PAGE_TOKEN = 'EAAOvR8M5Y5QBAKb1rzAZBZAnp0DocPBEgSYrSbGrrIGrddfAvwetYKJYbwrBbdK9slOBqvZBIuflzWu7fklIVwDO9UuqNa8vg6TNfIyFNEFHZBVIBhWIgb7WZB6DEcuVojEqbiadNlYOEd0SNOdVh8YZCqDB4ALvnt14rHifdXvAZDZD'
  VERIFY_TOKEN = 'bobisyouruncle'
  MESSAGE_URL = 'https://graph.facebook.com/v2.6/me/messages?access_token=' + PAGE_TOKEN

  # GET /pubthursday
  def challenge
    if params['hub.verify_token'] == VERIFY_TOKEN
      @response = params['hub.challenge']
    else
      @response = 'Error'
    end

    respond_to do |format|
      format.json { render json: @response, callback: params[:callback] }
    end
  end


  # POST /pubthursday
  def webhook
    if params['entry']
      params['entry'].each do |entry|
        if entry['messaging']
          entry['messaging'].each do |message|
            if message['sender']
              if message['sender']['id']
                sender_id = message['sender']['id']
              end
            end
            if message['message']
              if message['message']['text']
                text = message['message']['text']
              end
            end
            if sender_id and text
              send_message(sender_id, text)
            end
          end
        end
      end
    end

    respond_to do |format|
      format.json { render json: nil, callback: params[:callback] }
    end
  end


  private

  def send_message sender_id, text

    message = {
      "recipient" => {
        "id" => sender_id
      },
      "message" => {
        "text" => text
      }
    }

    message = {
      "recipient" => {
        "id" => sender_id
      },
      "message" => {
        "attachment" => {
          "type" => "template",
          "payload" => {
            "template_type" => "generic",
            "elements" => get_leaderboard().take(10),
          }
        }
      }
    }

    begin
      response = RestClient.post MESSAGE_URL, message.to_json, { :content_type => :json }
      return response
    rescue Exception => e
      logger.error "#{Time.now} Could not send facebook message: #{e.message}"
      logger.error message.to_json
    end
  end


  def get_leaderboard
    leaderboard = []
    begin
      response = RestClient.get 'http://52.49.119.75:8080/api/people'
      people = JSON.parse response.body
      people.each do |person|
        hash = Digest::MD5.hexdigest(person['email'].downcase)
        leaderboard << {
          "title" => person['name'],
          "subtitle" => person['status'],
          "image_url" => "http://www.gravatar.com/avatar/#{hash}"
        }
      end
      return leaderboard
    rescue Exception => e
      logger.error "#{Time.now} Could not pub thursday leaderboard: #{e.message}"
    end
    return []
  end

end
