class OnTheRunController < ApplicationController

  # GET /ontherun
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: nil, callback: params[:callback] }
      format.xml { render xml: nil }
    end
  end

end