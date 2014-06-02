require 'will_paginate/array'
class Trains::OperatingCompaniesController < ApplicationController


  # GET /trains/operating-companies
  # GET /trains/operating-companies.json
  # GET /trains/operating-companies.xml
  def index
    @q = params['q']
    @order = params[:order] || "name ASC"
    @operating_companies =  Trains::OperatingCompany.where("name = ? OR atoc = ? OR name LIKE ?", @q, @q, "#{@q}%").order(@order).paginate(@page)

    respond_to do |format|
      format.html
      format.json { render json: @operating_companies, callback: params['callback'] }
      format.xml { render xml: @operating_companies }
    end
  end


  # GET /trains/operating-companies/1
  # GET /trains/operating-companies/1.json
  # GET /trains/operating-companies/1.xml
  def show
    @operating_company = Trains::OperatingCompany.find(params[:id])
    @routes = @operating_company.routes(@page).order(:id).paginate(@page)

    respond_to do |format|
      format.html
      format.json { render json: @operating_company, callback: params['callback'] }
      format.xml { render xml: @operating_company }
    end
  end

end
