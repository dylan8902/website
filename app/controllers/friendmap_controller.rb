class FriendmapController < ApplicationController

  # GET /friendmap
  def index 
    Project.hit 5
  end

end