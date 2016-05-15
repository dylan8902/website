include ErrorHelper
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_page_and_limit
  before_filter :configure_devise_params, if: :devise_controller?
  before_filter :set_ie_header
  after_filter :analytics


  def set_page_and_limit
    limit = params[:limit] || 30
    @page = { page: params[:page], per_page: limit.to_i }
    
    permitted = [
      "created_at", "created_at DESC", "created_at ASC",
      "updated_at", "updated_at DESC", "updated_at ASC",
      "id", "id DESC", "id ASC",
      "name", "name DESC", "name ASC",
      "title", "title DESC", "title ASC",
      "distance", "distance DESC", "distance ASC",
    ]
    @order = params[:order] || "created_at DESC"
    error_404 unless permitted.include? @order
  end


  def error_404
    render_404
  end


  def error_410
    render_410
  end


  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password)
    end
  end


  def set_ie_header
    response.headers["X-UA-Compatible"] = "IE=edge,chrome=1"
  end


  def analytics
    Analytic.hit request
  end

end
