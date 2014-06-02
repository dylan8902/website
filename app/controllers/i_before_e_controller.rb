class IBeforeEController < ApplicationController

  # GET /IbeforeE
  def index 
    Project.hit 39
  end

end