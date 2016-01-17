class SecurityVulnerabilitiesController < ApplicationController
  include ErrorHelper
  before_filter :authenticate_user!, except: [:index, :show, :all]
  before_filter :authenticate_admin!, except: [:index, :show, :all]


  # GET /security-vulnerabilities
  # GET /security-vulnerabilities.json
  # GET /security-vulnerabilities.xml
  def index
    Project.hit 58
    @vulnerabilities = SecurityVulnerability.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vulnerabilities, callback: params[:callback] }
      format.xml { render xml: @vulnerabilities }
      format.rss { render 'feed' }
    end
  end


  # GET /security-vulnerabilities/all
  # GET /security-vulnerabilities/all.json
  # GET /security-vulnerabilities/all.xml
  def all
    Project.hit 58
    @page[:per_page] = SecurityVulnerability.count
    @vulnerabilities = SecurityVulnerability.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @vulnerabilities, callback: params[:callback] }
      format.xml { render xml: @vulnerabilities }
      format.rss { render 'feed' }
    end
  end

  # GET /securty-vulnerabilities/1
  # GET /securty-vulnerabilities/1.json
  # GET /securty-vulnerabilities/1.xml
  def show
    Project.hit 58
    @vulnerability = SecurityVulnerability.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vulnerability, callback: params[:callback] }
      format.xml { render xml: @vulnerability }
    end
  end


  # GET /securty-vulnerabilities/new
  # GET /securty-vulnerabilities/new.json
  # GET /securty-vulnerabilities/new.xml
  def new
    @vulnerability = SecurityVulnerability.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vulnerability, callback: params[:callback] }
      format.xml { render xml: @vulnerability }
    end
  end


  # GET /securty-vulnerabilities/1/edit
  def edit
    @vulnerability = SecurityVulnerability.find(params[:id])
  end


  # POST /securty-vulnerabilities
  # POST /securty-vulnerabilities.json
  def create
    @vulnerability = SecurityVulnerability.new(vulnerability_params)

    respond_to do |format|
      if @vulnerability.save
        format.html { redirect_to @vulnerability, notice: 'vulnerability was successfully created.' }
        format.json { render json: @vulnerability, status: :created, location: @vulnerability }
      else
        format.html { render action: "new" }
        format.json { render json: @vulnerability.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /securty-vulnerabilities/1
  # PUT /securty-vulnerabilities/1.json
  def update
    @vulnerability = SecurityVulnerability.find(params[:id])

    respond_to do |format|
      if @vulnerability.update_attributes(vulnerability_params)
        format.html { redirect_to @vulnerability, notice: 'vulnerability was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vulnerability.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /securty-vulnerabilities/1
  # DELETE /securty-vulnerabilities/1.json
  # DELETE /securty-vulnerabilities/1.xml
  def destroy
    @vulnerability = SecurityVulnerability.find(params[:id])
    @vulnerability.destroy

    respond_to do |format|
      format.html { redirect_to securty_vulnerabilities_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def vulnerability_params
      params.require(:security_vulnerability).permit(:domain, :url, :fixed, :summary, :description, :reported_at, :fixed_at)
    end

end
