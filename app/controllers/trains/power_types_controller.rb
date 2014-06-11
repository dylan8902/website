class Trains::PowerTypesController < ApplicationController

  # GET /trains/power-types
  # GET /trains/power-types.json
  # GET /trains/power-types.xml
  def index
    @q = params['q']    
    @order = params[:order] || "name ASC"
    @power_types =  Trains::PowerType.where("code = ? OR name LIKE ?", @q, "#{@q}%").order(@order).paginate(@page)

    respond_to do |format|
      format.html
      format.xml { render xml: @power_types }
      format.json { render json: @power_types, callback: params['callback'] }
    end
  end


  # GET /trains/power-types/1
  # GET /trains/power-types/1.json
  # GET /trains/power-types/1.xml
  def show
    @power_type = Trains::PowerType.find(params[:id])
    @page[:per_page] = 5
    @routes = @power_type.routes(@page).order(:id).paginate(@page)

    respond_to do |format|
      format.html
      format.xml { render xml: @power_type }
      format.json { render json: @power_type, callback: params['callback'] }
    end
  end

end
