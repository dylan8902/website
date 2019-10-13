class WestSideStory::StaticPagesController < ApplicationController
  layout "west_side_story"
  after_action :analytics


  # GET /westsidestory
  def index
  end


  # GET /westsidestory/synopsis
  def synopsis
  end


  # GET /westsidestory/team
  def team
  end


  # GET /westsidestory/cast
  def cast
  end


  # GET /westsidestory/tickets
  def tickets
  end


  # GET /westsidestory/contact
  def contact
  end


  private
    def analytics
      Project.hit 48
    end

end
