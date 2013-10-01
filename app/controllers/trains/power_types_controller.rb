class Trains::PowerTypesController < ApplicationController

  def index
    @q = params['q']    
    @power_types =  PowerType.where("code = ? OR name LIKE ?", @q, "#{@q}%").paginate(@page)

    respond_to do |format|
      format.html
      format.xml { render xml: @power_types }
      format.json { render json: @power_types, callback: params['callback'] }
    end

  end


  def show
    @power_type = PowerType.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render xml: @power_type }
      format.json { render json: @power_type, callback: params['callback'] }
    end

  end

end
