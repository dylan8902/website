class SolarReadingsController < ApplicationController
  include ErrorHelper
  before_action :authenticate_user!, only: [:create]
  before_action :authenticate_admin!, only: [:create]
  after_action :analytics

  # GET /solar
  # GET /solar.json
  # GET /solar.xml
  def index
    limit = params[:limit] || 30
    @page = { page: params[:page], per_page: limit.to_i }
    @order = params[:order] || "created_at"

    @readings = SolarReading.order(@order).paginate(@page)
    @total = SolarReading.total

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @readings, callback: params[:callback] }
      format.xml { render xml: @readings }
      format.rss { render 'feed' }
    end
  end


  # GET /solar/all
  # GET /solar/all.json
  # GET /solar/all.xml
  def all
    @page[:per_page] = SolarReading.count
    @readings = SolarReading.order(@order).paginate(@page)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @readings, callback: params[:callback] }
      format.xml { render xml: @readings }
      format.rss { render 'feed' }
    end
  end


  # GET /solar/1
  # GET /solar/1.json
  # GET /solar/1.xml
  def show
    @reading = SolarReading.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reading, callback: params[:callback] }
      format.xml { render xml: @reading }
    end
  end


  # POST /solar
  # POST /solar.json
  # POST /solar.xml
  def create
    @readings = []
    lines = Base64.decode64 params[:file].sub('data:text/csv;base64,','')
    solar_readings = lines.split("\n").reverse
    solar_readings.each do |reading|
      reading = reading.split(";")
      begin
        date = DateTime.strptime(reading[0], '%d/%m/%Y')
        @readings << SolarReading.where(date: date).first_or_create.update(kwh: reading[1])
      rescue ArgumentError => e
        logger.error(e.message)
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @readings, callback: params[:callback] }
      format.xml { render xml: @readings }
    end
  end


  # GET /solar/stats
  # GET /solar/stats.json
  # GET /solar/stats.xml
  def stats
    @stats = time_data SolarReading.all

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(SolarReading.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(SolarReading.all, :hash) }
    end
  end


  private

    def time_data data, type = :array
      months = Array.new(13).fill(0)
      days = Array.new(7).fill(0)
      data.each do |item|
        months[item.date.month-1] += item.kwh
        days[item.date.wday] += item.kwh
      end

      if type == :array
        time = {
          month_in_year: months,
          days_of_week: days
        }
        return time
      elsif type == :hash
        time = {
          month_in_year: Hash[Date::MONTHNAMES.zip months],
          days_of_week: Hash[Date::DAYNAMES.zip days]
        }
        return time
      end
    end


    def analytics
      Project.hit 62
    end


end
