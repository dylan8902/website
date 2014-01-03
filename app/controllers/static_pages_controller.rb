class StaticPagesController < ApplicationController
  include ErrorHelper
  before_filter :authenticate_user!, only: [:todo]
  before_filter :authenticate_admin!, only: [:todo]
  
  
  # GET /
  # GET /.json
  # GET /.xml
  def index
    @stuff = Project.limit(8)
    @tweets = Tweet.limit(4)
    @photos = Photo.limit(27)
    @episodes = Episode.limit(5)
    @blog_posts = BlogPost.limit(6)
    @location = Location.first
    @listens = Listen.limit(6)
    
    data = { stuff: @stuff, tweets: @tweets, photos: @photos, episodes: @episodes, blog: @blog_posts, location: @location, listens: @listens }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: data, callback: params[:callback] }
      format.xml { render xml: data }
    end
  end
  
  
  # GET /who
  def who
  end
  
  
  # GET /todo
  def todo
  end
  
  
  # GET /contact
  # GET /contact.json
  # GET /contact.xml
  def contact
    @contact = Array.new
    @contact << { name: 'email', link: 'mailto:dyl@anjon.es', text: 'dyl@anjon.es', icon: "envelope" }
    @contact << { name: 'twitter', link: 'https://twitter.com/dylan8902', text: 'twitter.com/dylan8902', icon: "twitter-sign" }
    @contact << { name: 'facebook', link: 'https://www.facebook.com/dylan8902', text: 'facebook.com/dylan8902', icon: "facebook-sign" }
    @contact << { name: 'google', link: 'https://www.google.com/profiles/dylan8902', text: 'google.com/profiles/dylan8902', icon: "google-plus-sign" }
    @contact << { name: 'skype', link: 'skype://dylanjamesvernonjones?userinfo', text: 'dylanjamesvernonjones', icon: "skype" }
    @contact << { name: 'linkedin', link: 'http://uk.linkedin.com/in/dylanjamesvernonjones', text: 'linkedin.com/in/dylanjamesvernonjones', icon: "linkedin-sign" }
    
    respond_to do |format|
      format.html # contact.html.erb
      format.json { render json: @contact, callback: params[:callback] }
      format.xml { render xml: @contact }
    end
  end
  
  
  # POST /contact
  # POST /contact.json
  # POST /contact.xml
  def message
    sent = FeedbackMailer.email(params).deliver
    respond_to do |format|
      if sent
        format.html { redirect_to "/contact", notice: 'Thank you for your message.' }
        format.json { render json: nil, status: :created, location: contact_path }
      else
        format.html { render action: "contact" }
        format.json { render json: "Not quite right?", status: :unprocessable_entity }
      end
    end
  end
  
  
  # GET /sitemap
  # GET /sitemap.json
  # GET /sitemap.xml
  def sitemap
    @sitemap = Array.new
    @sitemap << { url: "/", status: "80%" }
    
    respond_to do |format|
      format.html # sitemap.html.erb
      format.json { render json: @sitemap, :callback => params[:callback] }
      format.xml { render xml: @sitemap }
    end
  end


  # GET /cron
  # GET /cron.json
  # GET /cron.xml
  def cron
    Photo.update
    Tweet.update
    Listen.update
    BbcTwitter.update
    Location.update
    Gig.update
    TextMessage.update

    respond_to do |format|
      format.html # cron.html.erb
      format.json { render json: true, :callback => params[:callback] }
      format.xml { render xml: true }
    end
  end
  
end
