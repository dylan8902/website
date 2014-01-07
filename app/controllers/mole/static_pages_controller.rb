class Mole::StaticPagesController < ApplicationController

  # GET /mole
  def index
    Project.hit 51

    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
