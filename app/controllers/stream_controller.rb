require 'will_paginate/array'
class StreamController < ApplicationController
  
  # GET /stream
  def index
    Project.hit 16
    @stream = []
    Project.all.each do |project|
      @stream << { title: project.title, description: project.description, created_at: project.created_at }
    end
    BlogPost.all.each do |post|
      @stream << { title: post.title, description: "I wrote a blog", created_at: post.created_at }
    end
    Tweet.all.each do |tweet|
      @stream << { title: "Tweet", description: tweet.text, created_at: tweet.created_at }
    end
    FacebookPost.all.each do |post|
      @stream << { title: "Facebook", description: post.text, created_at: post.created_at }
    end

    @stream.sort_by! do |post|
      post[:created_at]
    end
    @stream.reverse!
    @stream = @stream.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stream, callback: params[:callback] }
      format.xml { render xml: @stream }
    end
  end
 
end