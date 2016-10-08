require 'will_paginate/array'
class TextMessagesController < ApplicationController
  include Statistics
  include ErrorHelper
  before_action :authenticate_user!, except: [:stats, :cloud]
  before_action :authenticate_admin!, except: [:stats, :cloud]


  # GET /sms
  # GET /sms.json
  # GET /sms.xml
  def index
    @text_messages = TextMessage.order(@order).paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @text_messages, callback: params[:callback] }
      format.xml { render xml: @text_messages }
    end
  end


  # GET /sms/1
  # GET /sms/1.json
  # GET /sms/1.xml
  def show
    @text_message = TextMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text_message, callback: params[:callback] }
      format.xml { render xml: @text_message }
    end
  end


  # GET /sms/contact/4474766782
  # GET /sms/contact/4474766782.json
  # GET /sms/contact/4474766782.xml
  def contact
    @text_messages = TextMessage.find_all_by_contact(params[:contact]).order(@order).paginate(@page)
    @contact = params[:contact]

    respond_to do |format|
      format.html # contact.html.erb
      format.json { render json: @text_messages, callback: params[:callback] }
      format.xml { render xml: @text_messages }
    end
  end


  # GET /sms/stats
  # GET /sms/stats.json
  # GET /sms/stats.xml
  def stats
    Project.hit 15
    Project.hit 32
    @stats = time_data TextMessage.all
    @cloud = word_cloud TextMessage.pluck(:text)

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(TextMessage.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(TextMessage.all, :hash) }
    end
  end


end
