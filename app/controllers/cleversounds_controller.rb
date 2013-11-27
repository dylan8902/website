class CleversoundsController < ApplicationController


  # GET /cleversounds
  # GET /cleversounds.json
  # GET /cleversounds.xml
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: nil, callback: params[:callback] }
      format.xml { render xml: nil }
    end
  end

end
