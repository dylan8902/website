class JewelleryController < ApplicationController
  
  # GET /jewellery
  def index
    Project.hit 17
    render layout: false
  end
  
  
  # POST /jewellery
  def message
    render layout: false, template: 'jewellery/index'
  end
 
end