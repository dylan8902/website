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

    params['entry'].each do |entry|
      entry['messaging'].each do |message|
        sender_id = message['sender']['id']
        text = message['message']['text']
          send_message(sender_id, text)
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

    begin
      response = RestClient.post MESSAGE_URL, message.to_json, { :content_type => :json }
      return response
    rescue Exception => e
      logger.error "#{Time.now} Could not send facebook message: #{e.message}"
      logger.error message.to_json
    end
  end

end
