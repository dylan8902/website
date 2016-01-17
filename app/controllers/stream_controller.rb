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
        description: post.text.html_safe,
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

    Listen.all.each do |listen|
      text = ""
      text += listen.track if listen.track
      text += " - " + listen.artist if listen.artist
      @stream << {
        title: "Listen",
        description: text,
        icon: "music",
        created_at: listen.created_at,
        link: music_listen_path(listen)
      }
    end

    Photo.all.each do |photo|
      @stream << {
        title: "Photo",
        description: "<h5>#{photo.title}</h5><img src=\"#{photo.thumbnail}\" class=\"thumbnail\">".html_safe,
        icon: "camera",
        created_at: photo.created_at,
        link: photo_path(photo)
      }
    end

    Gig.all.each do |gig|
      @stream << {
        title: "Gig",
        description: gig.name,
        icon: "calendar",
        created_at: gig.created_at,
        link: music_gig_path(gig)
      }
    end

    RunningEvent.all.each do |running_event|
      @stream << {
        title: "Running",
        description: running_event.name,
        icon: "trophy",
        created_at: running_event.created_at,
        link: running_event_path(running_event)
      }
    end

    @stream.sort_by! { |post| post[@order] }
    @stream.reverse!
    @stream = @stream.paginate(@page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stream, callback: params[:callback] }
      format.xml { render xml: @stream }
    end
  end

end
