class ProjectsController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!, except: [:index, :show, :all]
  before_action :authenticate_admin!, except: [:index, :show, :all]


  # GET /stuff
  # GET /stuff.json
  # GET /stuff.xml
  def index
    @projects = Project.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects, callback: params[:callback] }
      format.xml { render xml: @projects }
      format.rss { render 'feed' }
    end
  end


  # GET /stuff/all
  # GET /stuff/all.json
  # GET /stuff/all.xml
  def all
    @page[:per_page] = Project.count
    @projects = Project.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @projects, callback: params[:callback] }
      format.xml { render xml: @projects }
      format.rss { render 'feed' }
    end
  end


  # GET /stuff/1
  # GET /stuff/1.json
  # GET /stuff/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project, callback: params[:callback] }
      format.xml { render xml: @project }
    end
  end


  # GET /stuff/new
  # GET /stuff/new.json
  # GET /stuff/new.xml
  def new
    @project = Project.new
    @url = stuff_index_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project, callback: params[:callback] }
      format.xml { render xml: @project }
    end
  end


  # GET /stuff/1/edit
  def edit
    @project = Project.find(params[:id])
    @url = stuff_path(@project)
  end


  # POST /stuff
  # POST /stuff.json
  # POST /stuff.xml
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_url, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
        format.xml { render xml: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.xml { render xml: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /stuff/1
  # PUT /stuff/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_url, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.xml { render xml: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /stuff/1
  # DELETE /stuff/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def project_params
      params.require(:project).permit(:title, :description, :url, :online)
    end

end
