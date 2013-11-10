require 'digest/md5'
class Md5Controller < ApplicationController
  
  # GET /md5
  # GET /md5.json
  # GET /md5.xml
  def index

    @md5 = Digest::MD5.hexdigest(params[:q]) if params[:q]
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: "\"#{@md5}\"", callback: params[:callback] }
      format.xml { render xml: @md5 }
    end
  end

end
