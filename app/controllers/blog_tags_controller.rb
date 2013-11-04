class BlogTagsController < ApplicationController

  
  # GET /blog/tags
  # GET /blog/tags.json
  # GET /blog/tags.xml
  def index
    @page[:order] = :tag
    @tags = BlogTag.select(:tag).uniq.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags, callback: params[:callback] }
      format.xml { render xml: @tags }
    end
  end


  # GET /blog/tag/tag
  # GET /blog/tag/tag.json
  # GET /blog/tag/tag.xml
  def show
    @tag = BlogTag.find_by_tag(params[:id])
    @blog_posts = @tag.blog_posts.paginate(@page)
    render_404 and return if @tag.nil?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag, methods: [:blog_posts], callback: params[:callback] }
      format.xml { render xml: @tag, methods: [:blog_posts] }
    end
  end

end
