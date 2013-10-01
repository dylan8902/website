class JewelleryController < ApplicationController
  
  # GET /jewellery
  def index
    Project.find(17).hit
    render layout: false
  end
  
  
  # POST /jewellery
  def message
    render layout: false, template: 'jewellery/index'
  end
 
end