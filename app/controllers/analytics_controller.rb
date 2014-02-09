require 'will_paginate/array'
class AnalyticsController < ApplicationController
  include Statistics
  include ErrorHelper
  before_filter :authenticate_user!
  before_filter :authenticate_admin!


  # GET /analytics
  # GET /analytics.json
  # GET /analytics.xml
  def index
    day =  Analytic.where("created_at > ?", Time.now - 1.day).order("created_at DESC")
    @analytics = {}
    @analytics[:projects] = Project.all.order("hits DESC")
    @analytics[:ips] = day.uniq.pluck(:ip)
    @analytics[:visits] = day
    @analytics[:user_agents] = day.uniq.pluck(:user_agent)
    @analytics[:total] = Analytic.count
    @analytics[:day] = day.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @analytics, callback: params[:callback] }
      format.xml { render xml: @analytics }
    end
  end


  # GET /analytics/1
  # GET /analytics/1.json
  # GET /analytics/1.xml
  def show
    @analytic = Analytic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @analytic, callback: params[:callback] }
      format.xml { render xml: @analytic }
    end
  end


  # GET /analytics/search
  # GET /analytics/search.json
  # GET /analytics/search.xml
  def search
    @analytics = Analytic.where(params.permit([:ip, :user_agent])).paginate(@page)

    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @analytics, callback: params[:callback] }
      format.xml { render xml: @analytics }
    end
  end


  # GET /analytics/stats
  # GET /analytics/stats.json
  # GET /analytics/stats.xml
  def stats
    year = Analytic.where("created_at > ?", Time.now - 1.year)
    @stats = time_data year

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(year, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(year, :hash) }
    end
  end

end