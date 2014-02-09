class UsersController < ApplicationController


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