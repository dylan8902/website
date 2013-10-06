include ErrorHelper
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_page_and_limit
  
  def set_page_and_limit
    limit = params[:limit] || 30
    order = params[:order] || "created_at DESC"
    
    @page = { page: params[:page], per_page: limit, order: order }
  end
  
  def error_404
    render_404
  end
end
