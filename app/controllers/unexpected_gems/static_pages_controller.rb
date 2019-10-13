class UnexpectedGems::StaticPagesController < ApplicationController
  layout "unexpected_gems"
  after_action :analytics

  # GET /
  def index
  end

  private
    def analytics
      # Project.hit 48
    end

end
