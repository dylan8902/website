class FriendsTvController < ApplicationController
  
  # GET /friendstv
  def index 
    Project.hit 31
  end
 
end