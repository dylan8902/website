module ErrorHelper
  
  def authenticate_admin!
    render_403 and return unless current_user.admin?
  end
  
  #403
  def render_403
    respond_to do |format|
      format.html { render status: 403, template: 'static_pages/403' }
      format.json { render json: { error: 403 }, callback: params[:callback] }
      format.xml { render xml: { error: 403 } }
    end
  end
  
  #404
  def render_404
    respond_to do |format|
      format.html { render status: 404, template: 'static_pages/404' }
      format.json { render json: { error: 404 }, callback: params[:callback] }
      format.xml { render xml: { error: 404 } }
    end
  end

end