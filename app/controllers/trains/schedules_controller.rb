class Trains::SchedulesController < ApplicationController
  include ErrorHelper


  # GET /trains/schedules
  # GET /trains/schedules.json
  # GET /trains/schedules.xml
  def index

  	if params['origin'] and params['origin'].length > 0 then
      @from = params['origin']
      @origin =  Trains::Location.where("crs = ? OR tiploc = ? OR name LIKE ?", @from, @from, "#{@from}%").limit(1).first
    end

    if params['destination'] and params['destination'].length > 0 then
      @to = params['destination']
      @destination =  Trains::Location.where("crs = ? OR tiploc = ? OR name LIKE ?", @to, @to, "#{@to}%").limit(1).first
    end

    if params['date'].nil?
      @date = Time.new Date.current.year, Date.current.month, Date.current.day
    else
      @date = Time.strptime(params['date'], '%Y-%m-%d')
    end

    if params['non_public'].nil?
      @non_public = false
    else
      @non_public = true
    end

    if params['buses'].nil?
      @buses = false
    else
      @buses = true
    end

    public = !@non_public

    if @origin and @destination then
      @schedules = Trains::Schedule.get_schedules(@origin, @destination, @date, public, @buses).paginate(@page)
    elsif @origin then
      @schedules = Trains::Schedule.get_schedules(@origin, nil, @date, public, @buses).paginate(@page)
    elsif @destination then
      @schedules = Trains::Schedule.get_schedules(nil, @destination, @date, public, @buses).paginate(@page)
    end

    respond_to do |format|
      format.html
      format.json { render json: @schedules, methods: [:power_type, :destination, :origin, :atoc, :category, :train_class], callback: params['callback'] }
      format.xml { render xml: @schedules, methods: [:power_type, :destination, :origin, :atoc, :category, :train_class] }
    end
  end


  # GET /trains/schedules/P123
  # GET /trains/schedules/P123.json
  # GET /trains/schedules/P123.xml
  def show_by_uid

=begin
  
    @schedules = Trains::Schedule.where(train_uid: params[:uid])
    if @schedules.count == 0
      render_404
      return
    end
=end
    if params[:year].nil? or params[:month].nil? or params[:day].nil?
      @date = Date.today
    else
      begin
        @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      rescue => e
        render_404 and return
      end
    end

    conditions = "train_uid = ? AND schedule_start_date <= ? AND schedule_end_date >= ?"
    @schedule = Trains::Schedule.where(conditions, params[:uid], @date, @date).order("stp_indicator ASC").first || render_404 and return

    puts @schedule.inspect

    respond_to do |format|
      format.html
      format.json { render json: @schedule, methods: [:power_type, :destination, :origin, :schedule_locations, :atoc, :category, :train_class], callback: params['callback'] }
      format.xml { render xml: @schedule, methods: [:power_type, :destination, :origin, :schedule_locations, :atoc, :category, :train_class] }
    end
  end


  # GET /trains/schedules/id/1
  # GET /trains/schedules/id/1.json
  # GET /trains/schedules/id/1.xml
  def show_by_id

    @schedule = Trains::Schedule.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @schedule, :methods => [:power_type, :destination, :origin, :schedule_locations, :atoc, :category, :train_class], :callback => params['callback'] }
      format.xml { render :xml => @schedule, :methods => [:power_type, :destination, :origin, :schedule_locations, :atoc, :category, :train_class] }
    end
  end


end
