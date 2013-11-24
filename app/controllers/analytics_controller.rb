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
    @analytics = {}
    @analytics[:ips] = Analytic.uniq.pluck(:ip).paginate(@page)
    @analytics[:uris] = Analytic.uniq.pluck(:uri).paginate(@page)
    @analytics[:user_agents] = Analytic.uniq.pluck(:user_agent).paginate(@page)

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


  # GET /analytics/stats
  # GET /analytics/stats.json
  # GET /analytics/stats.xml
  def stats
    @stats = time_data Analytic.where("created_at > ?", Time.now - 1.year)

    respond_to do |format|
      format.html # stats.html.erb
      format.json { render json: time_data(Analytic.all, :hash), callback: params[:callback] }
      format.xml { render xml: time_data(Analytic.all, :hash) }
    end
  end

end