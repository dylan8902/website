class MusicwallController < ApplicationController
  
  # GET /musicwall
  def index 
    Project.hit 47  end
 
end