class FriendmapController < ApplicationController
  
  # GET /friendmap
  def index 
    Project.find(5).hit
  end
 
end