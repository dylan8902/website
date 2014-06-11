class Trains::CategoriesController < ApplicationController


  # GET /trains/categories
  # GET /trains/categories.json
  # GET /trains/categories.xml
  def index
    @q = params['q']
    @order = params[:order] || "name ASC"
    @categories =  Trains::Category.where("code = ? OR name LIKE ?", @q, "#{@q}%").order(@order).paginate(@page)

    respond_to do |format|
      format.html
      format.xml { render xml: @categories }
      format.json { render json: @categories, callback: params['callback'] }
    end
  end


  # GET /trains/categories/1
  # GET /trains/categories/1.json
  # GET /trains/categories/1.xml
  def show
    @category = Trains::Category.find(params[:id])
    @page[:per_page] = 5
    @routes = @category.routes(@page).order(:id).paginate(@page)

    respond_to do |format|
      format.html
      format.xml { render xml: @category }
      format.json { render json: @category, callback: params['callback'] }
    end
  end

end
