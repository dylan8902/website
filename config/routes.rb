class Hostname
  def initialize(domain)
    @domain = domain
  end
  def matches?(request)
    request.host.include? @domain
  end
end

Website::Application.routes.draw do

  #ismytraindelayed
  constraints Hostname.new("ismytraindelayed.com") do
    get ""         => "is_my_train_delayed#departures"
    get "arrivals" => "is_my_train_delayed#arrivals"
    get "service"  => "is_my_train_delayed#service"
    get "stations" => "is_my_train_delayed#stations"
    match '*foo'   => 'application#error_404', via: [:get, :post, :patch, :delete]
  end

  #ismybusdelayed
  constraints Hostname.new("ismybusdelayed.com") do
    get ""         => "is_my_bus_delayed#index"
    get "stops"    => "is_my_bus_delayed#stops"
    match '*foo'   => 'application#error_404', via: [:get, :post, :patch, :delete]
  end

  #dylanjones.info
  constraints Hostname.new("dylanjones.info") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es/#{params[:path]}"}, via: [:get, :post, :patch, :delete]
  end
  
  #dyl.anjon.es
  constraints Hostname.new("dyl.anjon.es") do

    #301s
    get "",              to: redirect("/api"), constraints: { subdomain: 'api' }
    get "blog/id/:id",   to: redirect("/blog/%{id}")
    get "lifestream",    to: redirect("/stream")
    get "onradio",       to: redirect("/onradio/1")
    get "onradio1",      to: redirect("/onradio/1")
    get "onradio2",      to: redirect("/onradio/2")
    get "onradio1xtra",  to: redirect("/onradio/1xtra")
    get "onradio6music", to: redirect("/onradio/6music")
    get "projects",      to: redirect("/stuff")
    get "projects/:id",  to: redirect("/stuff/%{id}")
    get "texts",         to: redirect("sms/stats")
    get "texts/:id",     to: redirect("/sms/%{id}")
    get "smsstats",      to: redirect("sms/stats")
    get "tweetmap",      to: redirect("/tweets/map")
    get "tv",            to: redirect("/episodes")
    get "tv/:pid",       to: redirect("/episodes/%{pid}")
    get "tvstats",       to: redirect("/episodes/stats")
    get "music/artist",  to: redirect("/music/artists")
    get "music/artist/:id", to: redirect("/music/artists/%{id}")
  
    get ""                => "static_pages#index",    as: "root"

    get  "accounts/all"   => "accounts#all",          as: "all_accounts"
    resources :accounts, except: :show

    get  "analysis"       => "analysis#index"

    get  "analytics/ip/:ip" => "analytics#ip"
    get  "analytics/user-agent/:user_agent" => "analytics#user_agent"
    get  "analytics/stats"  => "analytics#stats",     as: "analytics_stats"
    resources :analytics,                             only: [:index, :show]

    get  "api"            => "api#index"
    resources :bank_transactions, path: "bank",       only: [:index, :create]
    get  "bbc-twitter"    => "bbc_twitter#index"

    get  "blog/all"       => "blog_posts#all",             as: "all_blog_posts"
    get  "blog/map"       => "blog_posts#map",             as: "blog_posts_map"
    delete "blog/tags/:id"  => "blog_tags#delete",    as: "delete_blog_tag"
    post "blog/:blog_post_id/tags" => "blog_tags#create"
    resources :blog_tags,         path: "blog/tags",  only: [:index, :show]
    resources :blog_posts,        path: "blog" do
      resources :blog_comments,   path: "comments",   except: [:index, :show, :new]
    end

    get  "browserwars"    => "browser_wars#index"
    get  "contact"        => "static_pages#contact"
    post "contact"        => "static_pages#message"  
    get  "cleversounds"   => "cleversounds#index"
    get  "clock"          => "clock#index"
    get  "cron"           => "static_pages#cron"

    get  "drop/:uri" => "drops#show", as: "drop"
    resources :drops,             path: "drop",       only: [:index, :create]

    get  "episodes/add"   => "episodes#add"
    get  "episodes/all"   => "episodes#all"
    get  "episodes/stats" => "episodes#stats",        as: "episodes_stats"
    resources :episodes,                              only: [:index, :show]

    get  "facebook/all"   => "facebook_posts#all",    as: "all_facebook_posts"
    get  "facebook/map"   => "facebook_posts#map",    as: "facebook_posts_map"
    get  "facebook/stats" => "facebook_posts#stats",  as: "facebook_posts_stats"
    resources :facebook_posts,    path: "facebook",   only: [:index, :show]

    get  "first-aid"      => "first_aid#index"
    get  "friendmap"      => "friendmap#index"
    get  "friendstv"      => "friends_tv#index"
    get  "foebook"        => "static_pages#gone"
    get  "IbeforeE"       => "i_before_e#index"
    get  "ip-tools"       => "ip_tools#index"
    resources :iphone_locations,  path: "iphone",     only: [:index, :show]
    get  "jewellery"      => "jewellery#index"
    post "jewellery"      => "jewellery#message"
    get  "jimmywales"     => "jimmy_wales#index"
    resources :locations,         path: "location",   only: [:index, :show]
    resources :local_tags,        path: "localtags",  except: [:new]
    get  "md5"            => "md5#index"
    get  "molly"          => "molly#index"
    get  "musicwall"      => "musicwall#index"

    namespace :music do
      root to: "music#index"

      get  "artists/:id/:title" => "artists#show"
      resources :artists, only: [:index, :show] do
        get  ":id/:title" => "artists#show"
      end

      resources :dj_events, path: "dj"

      get "gigs/map"      => "gigs#map",      as: "gigs_map"
      get "gigs/stats"    => "gigs#stats",    as: "gigs_stats"
      resources :gigs,    only: [:index, :show]

      get "listens/stats" => "listens#stats", as: "listen_stats"
      resources :listens, only: [:index, :show]
    end

    get  "nhtg11"         => "convicts#index"
    get  "onradio/1"      => "on_radio#one"
    get  "onradio/1xtra"  => "on_radio#one_xtra"
    get  "onradio/2"      => "on_radio#two"
    get  "onradio/3"      => "on_radio#three"
    get  "onradio/6music" => "on_radio#six_music"
    get  "ontherun"       => "on_the_run#index"
    get  "payapal"        => "pay_a_pal#index"

    get  "photos/all"     => "photos#all",             as: "all_photos"
    get  "photos/map"     => "photos#map",             as: "photos_map"
    get  "photos/stats"   => "photos#stats",           as: "photos_stats"
    resources :photos,                                only: [:index, :show]

    get  "pdfy"           => "pdfy#index"
    post "pdfy"           => "pdfy#pdf"
    get  "qr"             => "qr#index"
    get  "reading"        => "reading#index"
    get  "realtime"       => "realtime#index"
    get  "speak"          => "speak#index"
    get  "samaritans"     => "samaritans#index"

    get  "sms/all"        => "text_messages#all",      as: "all_text_messages"
    get  "sms/cloud"      => "text_messages#cloud",    as: "text_message_cloud"
    get  "sms/stats"      => "text_messages#stats",    as: "text_message_stats"
    get  "sms/contact/:contact" => "text_messages#contact", as: "text_message_contact"
    resources :text_messages,     path: "sms",        only: [:index, :show]

    get  "stream"         => "stream#index"
    get  "sitemap"        => "static_pages#sitemap"

    get  "stuff/all"  => "projects#all",              as: "all_stuff"
    resources :projects,        path: "stuff",        as: "stuff"

    get  "timestables"    => "times_tables#index"
    post "timestables"    => "times_tables#new"

    namespace :trains do
      root                                         to: 'static_pages#index'
      get  'schedules/id/:id',                     to: 'schedules#show_by_id',  as: 'schedule_id'
      get  'schedules/:uid',                       to: 'schedules#show_by_uid', as: 'schedule_uid'
      get  'schedules/:uid/:year/:month/:day',     to: 'schedules#show_by_uid', as: 'schedule_uid_and_date'
      resources :journeys,            path: 'journeys',            except: [:new] do
        resources :journey_legs,      path: 'legs',                except: [:index]
      end
      resources :sessions,                                         only: [:create]
      resources :schedules,                                        only: [:index]
      resources :locations,                                        only: [:index, :show]
      resources :operating_companies, path: 'operating-companies', only: [:index, :show]
      resources :power_types,         path: 'power-types',         only: [:index, :show]
      resources :categories,                                       only: [:index, :show]
    end

    get  "tweets/all"     => "tweets#all",            as: "all_tweets"
    get  "tweets/map"     => "tweets#map",            as: "tweets_map"
    get  "tweets/stats"   => "tweets#stats",          as: "tweets_stats"
    resources :tweets,                                             only: [:index, :show]

    devise_for :users, path: "users", path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
    as :user do
      get "login"         => "devise/sessions#new",     as: "new_session"
      get "logout"        => "devise/sessions#destroy", as: "logout"
    end
    resources :users,                                              only: [:show]

    get  "video"          => "video#index"
    get  "wall"           => "wall#index"
    get  "wall/highscores"=> "wall#high_scores",        as: "wall_high_scores"
    post "wall/highscores"=> "wall#submit_score"
    get  "who"            => "static_pages#who"
    match '*foo'          => 'application#error_404', via: [:get, :post, :patch, :delete]
  end

end