class JewelleryController < ApplicationController
  
  # GET /jewellery
  def index
    Project.hit 17
    render layout: false
  end
  
  
  # POST /jewellery
  def message
    sent = FeedbackMailer.email(params).deliver
    render layout: false, template: 'jewellery/index'
  end
 
end