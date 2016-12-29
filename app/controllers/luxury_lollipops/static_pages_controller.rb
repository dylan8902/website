class LuxuryLollipops::StaticPagesController < ApplicationController
  layout "luxury_lollipops"
  after_filter :analytics


  # GET /
  def index
  end


  private
    def analytics
      # Project.hit 48
    end

end
