class Trains::CategoriesController < ApplicationController

  def index
    @q = params['q']    
    @categories =  Category.where("code = ? OR name LIKE ?", @q, "#{@q}%").paginate(@page)

    respond_to do |format|
      format.html
      format.xml { render xml: @categories }
      format.json { render json: @categories, callback: params['callback'] }
    end

  end


  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html
      format.xml { render xml: @category }
      format.json { render json: @category, callback: params['callback'] }
    end

  end

end
