class IntoTheWoods::StaticPagesController < ApplicationController
  after_action :analytics
  layout "into_the_woods"


  # GET /intothewoods
  def index
  end


  # GET /intothewoods/synopsis
  def synopsis
  end


  # GET /intothewoods/events
  def events
  end


  # GET /intothewoods/contact
  def contact
  end


  private
    def analytics
      Project.hit 36
    end

end
