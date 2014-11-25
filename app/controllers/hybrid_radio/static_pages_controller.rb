class HybridRadio::StaticPagesController < ApplicationController


  # GET /hybrid
  def index
    Project.hit 54
  end


end