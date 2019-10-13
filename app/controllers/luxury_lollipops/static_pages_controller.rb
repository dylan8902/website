class LuxuryLollipops::StaticPagesController < ApplicationController
  layout "luxury_lollipops"
  after_action :analytics

  # GET /
  def index
  end

  # GET /make-a-request
  def contact
  end

  # GET /take-a-look
  def photos
  end

  private
    def analytics
      # Project.hit 48
    end

end
