require 'will_paginate/array'
class StreamController < ApplicationController
  
  # GET /stream
  def index
    Project.hit 16
    @stream = []

    Project.all.each do |project|
      @stream << {
        title: project.title,
        description: project.description,
        icon: :code,
        created_at: project.created_at,
        link: project.url
      }
    end

    BlogPost.all.each do |post|
      @stream << {
        title: post.title,
        description: post.text.to(400).html_safe + "...",
        icon: :edit,
        created_at: post.created_at,
        link: blog_post_path(post)
      }
    end

    Tweet.all.each do |tweet|
      @stream << {
        title: "Tweet",
        description: tweet.text,
        icon: "twitter",
        created_at: tweet.created_at,
        link: tweet_path(tweet)
      }
    end

    FacebookPost.all.each do |post|
      @stream << {
        title: "Facebook",
        description: post.text,
        icon: "facebook",
        created_at: post.created_at,
        link: facebook_post_path(post)
      }
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