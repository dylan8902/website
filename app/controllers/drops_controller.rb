class DropsController < ApplicationController
  
  # GET /drops
  def index
  end


  # GET /drops/1
  # GET /drops/1.json
  # GET /drops/1.xml
  def show
    @drop = Drop.find_by_uri(params[:uri])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @drop }
      format.xml { render xml: @drop }
    end
  end


  # POST /drops
  # POST /drops.json
  # POST /drops.xml
  def create
        
    uri = Drop.generate_uri
    
    content_type = params[:file]
    base64 = params[:file]
    @drop = Drop.new(base64: base64, content_type:content_type, uri: uri)

    respond_to do |format|
      if @drop.save
        format.html { redirect_to @drop, notice: 'Drop was successfully created.' }
        format.json { render json: @drop, status: :created, location: @drop }
        format.xml { render xml: @drop, status: :created, location: @drop }
      else
        format.html { render action: "new" }
        format.json { render json: @drop.errors, status: :unprocessable_entity }
        format.xml { render xml: @drop.errors, status: :unprocessable_entity }
      end
    end
  end


end
