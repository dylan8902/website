class ProjectsController < ApplicationController
  include ErrorHelper
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_admin!, :except => [:index, :show]
  
  # GET /stuff
  # GET /stuff.json
  def index
    
    if params[:order_by].nil? or params[:order_by] == "created_at" 
      @order = "created_at DESC"
    elsif params[:order_by] == "hits" 
      @order = "hits DESC"
    elsif params[:order_by] == "title"
      @order = "title ASC"
    end
    
    @projects = Project.unscoped.order(@order).paginate(@page)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects, callback: params[:callback] }
      format.xml { render xml: @projects }
    end
  end

  # GET /stuff/1
  # GET /stuff/1.json
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
  def new
    @project = Project.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project, callback: params[:callback] }
      format.xml { render xml: @project }
    end
  end

  # GET /stuff/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /stuff
  # POST /stuff.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stuff/1
  # PUT /stuff/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
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
    end
  end
end
