class Mole::AddonsController < ApplicationController


  # GET /mole/addons
  # GET /mole/addons.json
  # GET /mole/addons.xml
  def index
    @page[:per_page] = 20
    @addons = Mole::Addon.order(:id).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @addons, callback: params[:callback] }
      format.xml { render xml: @addons }
    end
  end


  # GET /mole/addons/all
  # GET /mole/addons/all.json
  # GET /mole/addons/all.xml
  def all
    @page[:per_page] = Mole::Addon.count
    @addons = Mole::Addon.order(:id).paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @addons, callback: params[:callback] }
      format.xml { render xml: @addons }
    end
  end

end