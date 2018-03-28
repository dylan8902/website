class RemindersController < ApplicationController

  # GET /reminder-bot
  # GET /reminder-bot.json
  # GET /reminder-bot.xml
  def index
    Project.hit 58
    @reminders = Reminder.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reminders, callback: params[:callback] }
      format.xml { render xml: @reminders }
      format.rss { render 'feed' }
    end
  end


  # GET /reminder-bot/all
  # GET /reminder-bot/all.json
  # GET /reminder-bot/all.xml
  def all
    Project.hit 58
    @page[:per_page] = Reminder.count
    @reminders = Reminder.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @reminders, callback: params[:callback] }
      format.xml { render xml: @reminders }
      format.rss { render 'feed' }
    end
  end

  # GET /reminder-bot/1
  # GET /reminder-bot/1.json
  # GET /reminder-bot/1.xml
  def show
    Project.hit 58
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reminder, callback: params[:callback] }
      format.xml { render xml: @reminder }
    end
  end


  # GET /reminder-bot/new
  # GET /reminder-bot/new.json
  # GET /reminder-bot/new.xml
  def new
    @reminder = Reminder.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reminder, callback: params[:callback] }
      format.xml { render xml: @reminder }
    end
  end


  # GET /reminder-bot/1/edit
  def edit
    @reminder = Reminder.find(params[:id])
  end


  # POST /reminder-bot
  # POST /reminder-bot.json
  def create
    @reminder = Reminder.new(reminder_params)

    respond_to do |format|
      if @reminder.save
        format.html { redirect_to @reminder, notice: 'reminder was successfully created.' }
        format.json { render json: @reminder, status: :created, location: @reminder }
      else
        format.html { render action: "new" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /reminder-bot/1
  # PUT /reminder-bot/1.json
  def update
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      if @reminder.update_attributes(reminder_params)
        format.html { redirect_to @reminder, notice: 'reminder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end


  # POST /reminder-bot/1/test
  # POST /reminder-bot/1/test.json
  def test
    @reminder = Reminder.find(params[:id])
    @reminder.send

    respond_to do |format|
      format.html { render action: "show", notice: 'Test reminder sent' }
      format.json { render json: @reminder }
    end
  end


  # DELETE /reminder-bot/1
  # DELETE /reminder-bot/1.json
  # DELETE /reminder-bot/1.xml
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to securty_vulnerabilities_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  private
    def reminder_params
      params.require(:reminder).permit(:name, :time, :title, :summary, :url, :image)
    end

end
