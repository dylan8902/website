class XssWorkshopController < ApplicationController
  layout "xss_workshop"


  # GET /xss-workshop
  def index

    respond_to do |format|
      format.html
    end
  end

  # GET /xss-workshop/1
  def example1

    respond_to do |format|
      format.html
    end
  end

  # GET /xss-workshop/2
  def example2

    respond_to do |format|
      format.html
    end
  end

  # GET /xss-workshop/3
  def example3

    respond_to do |format|
      format.html
    end
  end

end
