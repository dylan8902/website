class UsersController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!, only: [:index]
  before_action :authenticate_admin!, only: [:index]

  # GET /users
  # GET /users.json
  # GET /users.xml
  def index
    @users = User.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users, callback: params[:callback] }
      format.xml { render xml: @users }
      format.rss { render 'feed' }
    end
  end


  # GET /users/1
  # GET /users/1.json
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user, callback: params[:callback] }
      format.xml { render xml: @user }
    end
  end


end