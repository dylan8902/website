class MusicwallController < ApplicationController
  
  # GET /musicwall
  def index 
    Project.find(7).hit
  end
 
end