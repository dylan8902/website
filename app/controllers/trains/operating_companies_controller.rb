class Trains::OperatingCompaniesController < ApplicationController

  def index
    @q = params['q']    
    @operating_companies =  Trains::OperatingCompany.where("name = ? OR atoc = ? OR name LIKE ?", @q, @q, "#{@q}%").paginate(@page)

    respond_to do |format|
      format.html
      format.json { render json: @operating_companies, callback: params['callback'] }
      format.xml { render xml: @operating_companies }
    end

  end


  def show
    @operating_company = Trains::OperatingCompany.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @operating_company, callback: params['callback'] }
      format.xml { render xml: @operating_company }
    end

  end

end
