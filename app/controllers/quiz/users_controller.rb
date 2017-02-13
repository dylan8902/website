class Quiz::UsersController < ApplicationController
  layout "team_quiz"
  include ErrorHelper
  before_action :authenticate_user!, except: [:create]
  before_action :authenticate_admin!, except: [:create]


  # GET /team-quiz/users
  # GET /team-quiz/users.json
  # GET /team-quiz/users.xml
  def index
    @users = Quiz::User.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users, callback: params[:callback] }
      format.xml { render xml: @users }
      format.rss { render 'feed' }
    end
  end


  # GET /team-quiz/users/1
  # GET /team-quiz/users/1.json
  # GET /team-quiz/users/1.xml
  def show
    @user = Quiz::User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user, callback: params[:callback] }
      format.xml { render xml: @user }
    end
  end


  # GET /team-quiz/users/1/edit
  def edit
    @user = Quiz::User.find(params[:id])
  end


  # POST /team-quiz/users
  # POST /team-quiz/users.json
  def create
    @user = Quiz::User.new(user_params)

    respond_to do |format|
      if @user.save
        #TODO create a session cookie and redirect to start
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /team-quiz/users/1
  # PUT /team-quiz/users/1.json
  def update
    @user = Quiz::User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /team-quiz/users/1
  # DELETE /team-quiz/users/1.json
  # DELETE /team-quiz/users/1.xml
  def destroy
    @user = Quiz::User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to quiz_root_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def user_params
      params.require(:quiz_user).permit(:nickname)
    end

end
