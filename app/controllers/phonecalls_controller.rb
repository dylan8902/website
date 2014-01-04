class PhonecallsController < ApplicationController
  include Statistics
  include ErrorHelper
  before_filter :authenticate_user!, except: :stats
  before_filter :authenticate_admin!, except: :stats


  # GET /phonecalls
  # GET /phonecalls.json
  # GET /phonecalls.xml
  def index
    @page[:per_page] = params[:limit] || 100
    @phonecalls = Phonecall.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phonecalls, callback: params[:callback] }
      format.xml { render xml: @phonecalls }
    end
  end


  # GET /phonecalls/1
  # GET /phonecalls/1.json
  # GET /phonecalls/1.xml
  def show
    @phonecall = Phonecall.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @phonecall, callback: params[:callback] }
      format.xml { render xml: @phonecall }
    end
  end


  # GET /phonecalls/all
  # GET /phonecalls/all.json
  # GET /phonecalls/all.xml
  def all
    @page[:per_page] = Phonecall.count
    @phonecalls = Phonecall.paginate(@page)

    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @phonecalls, callback: params[:callback] }
      format.xml { render xml: @phonecalls }
    end
  end


  # POST /phonecalls
  # POST /phonecalls.json
  # POST /phonecalls.xml
  def create
    @phonecalls = []

    lines = Base64.decode64 params[:file].sub('data:text/csv;base64,','')
    phonecalls = lines.split("\n").reverse

    phonecalls.each do |phonecall|
      phonecall = phonecall.split(",")
      time = DateTime.strptime(phonecall[0] + " " + phonecall[1], '%d %b %y %H:%M:%S')
      @phonecalls <<  Phonecall.create(
        date: phonecall[0],
        time: phonecall[1],
        contact: phonecall[2],
        category: phonecall[3],
        duration: phonecall[4],
        price: phonecall[5],
        included: phonecall[6],
        created_at: time,
        updated_at: time
      )
    end

    respond_to do |format|
      format.html 
      format.json { render json: true, callback: params[:callback] }
      format.xml { render xml: @phonecalls }
    end
  end


  # GET /sms/contact/4474766782
  # GET /sms/contact/4474766782.json
  # GET /sms/contact/4474766782.xml
  def contact
    @phonecalls = Phonecall.find_all_by_contact(params[:contact]).paginate(@page)
    @contact = params[:contact]
    
    respond_to do |format|
      format.html # contact.html.erb
      format.json { render json: @phonecalls, callback: params[:callback] }
      format.xml { render xml: @phonecalls }
    end
  end


  # GET /phonecalls/stats
  # GET /phonecalls/stats.json
  # GET /phonecalls/stats.xml
  def stats
    Project.hit 26
    @stats = time_data Phonecall.all

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(Photo.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Photo.all, :hash) }
    end
  end


end