class ApiController < ApplicationController

  PAGE_TOKEN = 'EAAOvR8M5Y5QBAKb1rzAZBZAnp0DocPBEgSYrSbGrrIGrddfAvwetYKJYbwrBbdK9slOBqvZBIuflzWu7fklIVwDO9UuqNa8vg6TNfIyFNEFHZBVIBhWIgb7WZB6DEcuVojEqbiadNlYOEd0SNOdVh8YZCqDB4ALvnt14rHifdXvAZDZD'
  VERIFY_TOKEN = 'bobisyouruncle'

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


    respond_to do |format|
      format.json { render json: @response, callback: params[:callback] }
    end
  end

end
