class DudeWheresMyCarController < ApplicationController

  # GET /dudewheresmycar
  def index
    Project.hit 46
  end

end