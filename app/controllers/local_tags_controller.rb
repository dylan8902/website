class LocalTagsController < ApplicationController


  # GET /localtags
  # GET /localtags.json
  # GET /localtags.xml
  def index
    @local_tag = LocalTag.new
    @local_tags = LocalTag.all
    @locations = @local_tags

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @local_tags }
      format.xml { render xml: @local_tags }
    end
  end


  # GET /localtags/1
  # GET /localtags/1.json
  # GET /localtags/1.xml
  def show
    @local_tag = LocalTag.find(params[:id])
    @location = @local_tag

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @local_tag }
      format.xml { render xml: @local_tag }
    end
  end


  # GET /localtags/1/edit
  def edit
    @local_tag = LocalTag.find(params[:id])
  end


  # POST /localtags
  # POST /localtags.json
  # POST /localtags.xml
  def create

    if user_signed_in?
      user_id = current_user.id
    end

    @local_tag = LocalTag.new(local_tag_params.merge(user_id: user_id))

    respond_to do |format|
      if @local_tag.save
        format.html { redirect_to @local_tag, notice: 'Local tag was successfully created.' }
        format.json { render json: @local_tag, status: :created, location: @local_tag }
        format.xml { render xml: @local_tag, status: :created, location: @local_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @local_tag.errors, status: :unprocessable_entity }
        format.xml { render xml: @local_tag.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /localtags/1
  # PUT /localtags/1.json
  # PUT /localtags/1.xml
  def update
    @local_tag = LocalTag.find(params[:id])

    respond_to do |format|
      if @local_tag.update_attributes(local_tag_params)
        format.html { redirect_to @local_tag, notice: 'Local tag was successfully updated.' }
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @local_tag.errors, status: :unprocessable_entity }
        format.xml { render xml: @local_tag.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /localtags/1
  # DELETE /localtags/1.json
  # DELETE /localtags/1.xml
  def destroy
    @local_tag = LocalTag.find(params[:id])
    @local_tag.destroy

    respond_to do |format|
      format.html { redirect_to local_tags_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end

  private
    def local_tag_params
      params.require(:local_tag).permit(:title, :description, :lat, :lng)
    end

end
