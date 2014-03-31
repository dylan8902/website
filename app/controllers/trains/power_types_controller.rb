class Trains::PowerTypesController < ApplicationController

  # GET /trains/power-types
  # GET /trains/power-types.json
  # GET /trains/power-types.xml
  def index
    @q = params['q']    
    @page[:order] = "name ASC"    
    @power_types =  Trains::PowerType.where("code = ? OR name LIKE ?", @q, "#{@q}%").paginate(@page)

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
    @page[:order] = "id"
    @page[:limit] = 5
    @routes = @power_type.routes(@page).paginate(@page)

    respond_to do |format|
      format.html
      format.xml { render xml: @power_type }
      format.json { render json: @power_type, callback: params['callback'] }
    end

  end

end
