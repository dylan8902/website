class StaticPagesController < ApplicationController
  
  
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
  # GET /who.json
  # GET /who.xml
  def who

    respond_to do |format|
      format.html # who.html.erb
      format.json { render json: "Dylan Jones", callback: params[:callback] }
      format.xml { render xml: "Dylan Jones" }
    end
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

    @sitemap = [
      { loc: root_url, changefreq: :always },
      { loc: who_url, changefreq: :monthly },
      { loc: all_stuff_url, changefreq: :monthly },
      { loc: contact_url, changefreq: :monthly },
    ]
    Project.where("url LIKE ?", "%dyl.anjon.es/%").each do |project|
      @sitemap << { loc: project.url, lastmod: project.updated_at.iso8601, changefreq: :always }
    end

    @sitemap << { loc: blog_posts_url, changefreq: :monthly }
    @sitemap << { loc: blog_tags_url, changefreq: :monthly }
    BlogPost.all.each do |blog_post|
      @sitemap << { loc: blog_post_url(blog_post), lastmod: blog_post.updated_at.iso8601, changefreq: :never }
    end

    Episode.all.each do |episode|
      @sitemap << { loc: episode_url(episode), lastmod: episode.created_at.iso8601, changefreq: :never }
    end

    @sitemap << { loc: facebook_posts_url }
    @sitemap << { loc: facebook_posts_stats_url }
    @sitemap << { loc: facebook_posts_map_url }
    FacebookPost.all.each do |facebook_post|
      @sitemap << { loc: facebook_post_url(facebook_post), lastmod: facebook_post.created_at.iso8601, changefreq: :never }
    end

    @sitemap << { loc: tweets_url }
    @sitemap << { loc: tweets_stats_url }
    @sitemap << { loc: tweets_map_url }
    Tweet.all.each do |tweet|
      @sitemap << { loc: tweet_url(tweet), lastmod: tweet.created_at.iso8601, changefreq: :never }
    end

    respond_to do |format|
      format.html # sitemap.html.erb
      format.json { render json: @sitemap, callback: params[:callback] }
      format.xml { @sitemap }
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
      format.json { render json: true, callback: params[:callback] }
      format.xml { render xml: true }
    end
  end
  
end
