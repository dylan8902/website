require 'will_paginate/array'
class BlogTagsController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!, only: [:delete]
  before_action :authenticate_admin!, only: [:delete]


  # GET /blog/tags
  # GET /blog/tags.json
  # GET /blog/tags.xml
  def index
    @tags = BlogTag.uniq.pluck(:tag).paginate(@page)

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
    render_404 and return if @tag.nil?
    @blog_posts = @tag.blog_posts.order(@order).paginate(@page)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag, methods: [:blog_posts], callback: params[:callback] }
      format.xml { render xml: @tag, methods: [:blog_posts] }
      format.rss { render 'blog_posts/feed' }
    end
  end


  # POST /blog/1/tags
  # POST /blog/1/tags.json
  # POST /blog/1/tags.xml
  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
    render_404 and return if @blog_post.nil?
    @tag = BlogTag.new(blog_tag_params.merge(blog_post_id: @blog_post.id))

    respond_to do |format|
      if @tag.save
        format.html { redirect_to edit_blog_post_path(@blog_post), notice: 'Tag was successfully created.' }
        format.json { render json: @tag, status: :created, location: @blog_post }
        format.xml { render xml: @tag, status: :created, location: @blog_post }
      else
        format.html { render action: "blog_post#edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /blog/tag/id/1
  # DELETE /blog/tag/id/1.json
  # DELETE /blog/tag/id/1.xml
  def delete
    @tag = BlogTag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to edit_blog_post_path(@tag.blog_post), notice: 'Tag was successfully removed.' }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def blog_tag_params
      params.require(:blog_tag).permit(:tag)
    end

end
