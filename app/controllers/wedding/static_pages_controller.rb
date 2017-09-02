class Wedding::StaticPagesController < ApplicationController
  layout "wedding"


  # GET /wedding
  def index
    @rsvp = Wedding::Rsvp.new

    respond_to do |format|
      format.html
    end
  end


  # GET /wedding/gifts
  def gifts

    respond_to do |format|
      format.html
    end
  end

end
