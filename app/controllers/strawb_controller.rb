class StrawbController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # GET /strawb
  # GET /strawb.json
  # GET /strawb.xml
  # POST /strawb
  # POST /strawb.json
  # POST /strawb.xml
  def index

    puts params
    @response = {
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

    respond_to do |format|
      format.html { render json: @response, callback: params[:callback] }
      format.json { render json: @response, callback: params[:callback] }
      format.xml { render xml: @response}
    end
  end

end
