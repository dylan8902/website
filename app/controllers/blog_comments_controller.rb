class BlogCommentsController < ApplicationController
  include ErrorHelper
  before_filter :authenticate_user!, except: [:show, :create]


  # GET /blog/1/comments/1/edit
  def edit
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = BlogComment.find_by_id_and_blog_post_id(params[:id], @blog_post)
    render_404 and return if @comment.nil?
    render_403 and return if current_user.nil? or @comment.user_id != current_user.id
    @url = blog_post_blog_comment_path(@blog_post, @comment)
    @method = :PUT
  end


  # POST /blog/1/comments
  # POST /blog/1/comments.json
  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
    user_id = current_user.id if current_user
    @comment = BlogComment.new(blog_comment_params.merge(blog_post_id: @blog_post.id, user_id: user_id))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @blog_post, notice: 'Thanks for the comment!' }
        format.json { render json: @blog_post, status: :created, location: @blog_post }
      else
        format.html { render action: "new" }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /blog/1/comments/1
  # PUT /blog/1comments/1.json
  # PUT /blog/1comments/1.xml
  def update
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = BlogComment.find(params[:id])
    render_404 and return if @blog_post.id != @comment.blog_post_id
    render_403 and return if @comment.user_id != current_user.id

    respond_to do |format|
      if @comment.update_attributes(blog_comment_params)
        format.html { redirect_to @blog_post, notice: 'Your comment was successfully updated.' }
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.xml { render xml: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /blog/1
  # DELETE /blog/1.json
  # DELETE /blog/1.xml
  def destroy
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = BlogComment.find(params[:id])
    render_404 and return if @blog_post.id != @comment.blog_post_id
    render_403 and return if @comment.user_id != current_user.id

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def blog_comment_params
      params.require(:blog_comment).permit(:name, :email, :comment)
    end
end
