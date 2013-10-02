class PayAPalController < ApplicationController
  include ErrorHelper
    
  # GET /payapal
  # GET /payapal.json
  # GET /payapal.xml
  def index
    @css = []
    
    respond_to do |format|
      format.html { render layout: 'paralex' }
      format.json { render json: [], callback: params[:callback] }
      format.xml { render xml: [] }
    end
  end

 
end
