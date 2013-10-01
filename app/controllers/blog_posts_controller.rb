class BlogPostsController < ApplicationController
  include ErrorHelper
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_admin!, :except => [:index, :show]
  
  # GET /blog
  # GET /blog.json
  # GET /blog.xml
  def index
    @blog_posts = BlogPost.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blog_posts, callback: params[:callback] }
      format.xml { render xml: @blog_posts }
    end
  end

  # GET /blog/1
  # GET /blog/1.json
  def show
    @blog_post = BlogPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog_post, callback: params[:callback] }
      format.xml { render xml: @blog_post }
    end
  end


  # GET /blog/new
  # GET /blog/new.json
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
  end

  # POST /blog
  # POST /blog.json
  def create
    @blog_post = BlogPost.new(params[:account])

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
  def update
    @blog_post = BlogPost.find(params[:id])

    respond_to do |format|
      if @blog_post.update_attributes(params[:blog_post])
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog/1
  # DELETE /blog/1.json
  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_url }
      format.json { head :no_content }
    end
  end
end
