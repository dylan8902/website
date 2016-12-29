class LuxuryLollipops::StaticPagesController < ApplicationController
  layout "luxury_lollipops"
  after_filter :analytics

  # GET /
  def index
  end

  # GET /make-a-request
  def request
  end

  # GET /take-a-look
  def photos
  end

  private
    def analytics
      # Project.hit 48
    end

end
