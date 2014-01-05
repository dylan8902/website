class BlogPostsController < ApplicationController
  include ErrorHelper
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :authenticate_admin!, except: [:index, :show]


  # GET /blog
  # GET /blog.json
  # GET /blog.xml
  def index
    @page[:per_page] = params[:limit] || 5
    @blog_posts = BlogPost.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blog_posts, callback: params[:callback] }
      format.xml { render xml: @blog_posts }
      format.rss { render 'feed' }
    end
  end


  # GET /blog/all
  # GET /blog/all.json
  # GET /blog/all.xml
  def all
    @page[:per_page] = BlogPost.count
    @blog_posts = BlogPost.paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @blog_posts, callback: params[:callback] }
      format.xml { render xml: @blog_posts }
      format.rss { render 'feed' }
    end
  end


  # GET /blog/1
  # GET /blog/1.json
  # GET /blog/1.xml
  def show
    @blog_post = BlogPost.find(params[:id])

    @comments = @blog_post.blog_comments.paginate(@page)
    @comment = BlogComment.new
    @url = blog_post_blog_comments_path(@blog_post)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog_post, callback: params[:callback] }
      format.xml { render xml: @blog_post }
    end
  end


  # GET /blog/new
  # GET /blog/new.json
  # GET /blog/new.xml
  def new
    @blog_post = BlogPost.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blog_post, callback: params[:callback] }
      format.xml { render xml: @blog_post }
    end
  end


  # GET /blog/1/edit
  def edit
    @blog_post = BlogPost.find(params[:id])
    @tag = BlogTag.new
  end


  # POST /blog
  # POST /blog.json
  def create
    @blog_post = BlogPost.new(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully created.' }
        format.json { render json: @blog_post, status: :created, location: @blog_post }
      else
        format.html { render action: "new" }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /blog/1
  # PUT /blog/1.json
  # PUT /blog/1.xml
  def update
    @blog_post = BlogPost.find(params[:id])

    respond_to do |format|
      if @blog_post.update_attributes(blog_post_params)
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully updated.' }
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
        format.xml { render xml: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /blog/1
  # DELETE /blog/1.json
  # DELETE /blog/1.xml
  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def blog_post_params
      params.require(:blog_post).permit(:title, :text)
    end
end
