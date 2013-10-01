class FriendsTvController < ApplicationController
  
  # GET /friendstv
  def index 
    Project.find(31).hit
  end
 
end