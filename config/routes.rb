class Domain
  def initialize(domain)
    @domain = domain
  end
  def matches?(request)
    request.host == @domain || request.host == "dev.#{@domain}"
  end
end

Website::Application.routes.draw do

  #keepintouchabroad
  constraints Domain.new("www.keepintouchabroad.com") do
    match "/(*path)" => redirect {|params, req| "http://keepintouchabroad.com#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("keepintouchabroad.com") do
    scope module: 'kita' do
      get ""         => 'static_pages#index'
      match '*url'   => 'static_pages#index', via: [:get, :post, :patch, :delete]
    end
  end

  #hiddengifts
  constraints Domain.new("www.hiddengifts.co.uk") do
    match "/(*path)" => redirect {|params, req| "http://hiddengifts.co.uk#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("hiddengifts.co.uk") do
    scope module: 'hidden_gifts' do
      get ""         => 'static_pages#index'
      match '*url'   => 'static_pages#index', via: [:get, :post, :patch, :delete]
    end
  end

  #stjohn
  constraints Domain.new("www.stjohn.dyl.anjon.es") do
    match "/(*path)" => redirect {|params, req| "http://www.stjohnwales.org.uk/apps/firstaidapp#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("stjohn.dyl.anjon.es") do
    match "/(*path)" => redirect {|params, req| "http://www.stjohnwales.org.uk/apps/firstaidapp#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end

  #intothewoodsyork
  constraints Domain.new("www.intothewoodsyork.dyl.anjon.es") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es/intothewoods#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("intothewoodsyork.dyl.anjon.es") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es/intothewoods#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end

  #westsidestory
  constraints Domain.new("www.westsidestory2013.dyl.anjon.es") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es/westsidestory#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("westsidestory2013.dyl.anjon.es") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es/westsidestory#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("www.westsidestory.dyl.anjon.es") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es/westsidestory#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("westsidestory.dyl.anjon.es") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es/westsidestory#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end

  #ismytraindelayed
  constraints Domain.new("www.ismytraindelayed.com") do
    match "/(*path)" => redirect {|params, req| "http://ismytraindelayed.com#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("ismytraindelayed.com") do
    get ""         => "is_my_train_delayed#departures"
    get "arrivals" => "is_my_train_delayed#arrivals"
    get "service"  => "is_my_train_delayed#service"
    get "stations" => "is_my_train_delayed#stations"
    match '*url'   => 'application#error_404', via: [:get, :post, :patch, :delete]
  end

  #ismybusdelayed
  constraints Domain.new("www.ismybusdelayed.com") do
    match "/(*path)" => redirect {|params, req| "http://ismybusdelayed.com#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("ismybusdelayed.com") do
    get ""         => "is_my_bus_delayed#index"
    get "stops"    => "is_my_bus_delayed#stops"
    match '*url'   => 'application#error_404', via: [:get, :post, :patch, :delete]
  end

  #ismyplanedelayed
  constraints Domain.new("www.ismyplanedelayed.com") do
    match "/(*path)" => redirect {|params, req| "http://ismyplanedelayed.com#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("ismyplanedelayed.com") do
    get ""         => "is_my_plane_delayed#departures"
    get "arrivals" => "is_my_plane_delayed#arrivals"
    get "flight"   => "is_my_plane_delayed#flight"
    get "airports" => "is_my_plane_delayed#airports"
    match '*url'   => 'application#error_404', via: [:get, :post, :patch, :delete]
  end

  #dylanjones.info
  constraints Domain.new("www.dylanjones.info") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("dylanjones.info") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end

  #dyl.anjon.es
  constraints Domain.new("www.dyl.anjon.es") do
    match "/(*path)" => redirect {|params, req| "https://dyl.anjon.es#{req.fullpath}"}, via: [:get, :post, :patch, :delete]
  end
  constraints Domain.new("dyl.anjon.es") do
    #301s
    get "",              to: redirect("/api"), constraints: { subdomain: 'api' }
    get "blog/id/:id",   to: redirect("/blog/%{id}")
    get "blog/post/:id", to: redirect("/blog/%{id}")
    get "lifestream",    to: redirect("/stream")
    get "onradio",       to: redirect("/onradio/1")
    get "onradio1",      to: redirect("/onradio/1")
    get "onradio2",      to: redirect("/onradio/2")
    get "onradio1xtra",  to: redirect("/onradio/1xtra")
    get "onradio6music", to: redirect("/onradio/6music")
    get "projects",      to: redirect("/stuff")
    get "projects/:id",  to: redirect("/stuff/%{id}")
    get "sms/cloud",     to: redirect("/sms/stats")
    get "texts",         to: redirect("sms/stats")
    get "texts/:id",     to: redirect("/sms/%{id}")
    get "smsstats",      to: redirect("sms/stats")
    get "tweetmap",      to: redirect("/tweets/map")
    get "tv",            to: redirect("/episodes")
    get "tv/:pid",       to: redirect("/episodes/%{pid}")
    get "tvstats",       to: redirect("/episodes/stats")
    get "music/artist",  to: redirect("/music/artists")
    get "music/artist/:id", to: redirect("/music/artists/%{id}")
    get "listen/:id",    to: redirect("/music/listens/%{id}")
    get "listens/:id",   to: redirect("/music/listens/%{id}")
    get "playorslay",    to: redirect("/slayorplay")

    get ""                => "static_pages#index",    as: "root"

    get  "accounts/all"   => "accounts#all",          as: "all_accounts"
    resources :accounts, except: :show

    get  "analysis"       => "analysis#index"

    get  "analytics/search" => "analytics#search",    as: "analytics_search"
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
    get  "deepdive"       => "deep_dive#index"

    get  "drop/:uri" => "drops#show", as: "drop"
    resources :drops,             path: "drop",       only: [:index, :create]

    get  "dudewheresmycar"=> "dude_wheres_my_car#index"

    get  "episodes/add"   => "episodes#add"
    get  "episodes/all"   => "episodes#all"
    get  "episodes/stats" => "episodes#stats",        as: "episodes_stats"
    get  "episodes/users/:id" => "episodes#user",     as: "user_episodes"
    get  "episodes/users/:id/stats" => "episodes#user_stats",     as: "user_episodes_stats"
    resources :episodes,                              only: [:index, :show]

    get  "facebook/all"   => "facebook_posts#all",    as: "all_facebook_posts"
    get  "facebook/map"   => "facebook_posts#map",    as: "facebook_posts_map"
    get  "facebook/stats" => "facebook_posts#stats",  as: "facebook_posts_stats"
    resources :facebook_posts,    path: "facebook",   only: [:index, :show]

    get  "first-aid"      => "first_aid#index"
    get  "friendmap"      => "friendmap#index"
    get  "friendstv"      => "friends_tv#index"
    get  "foebook"        => "application#error_410"

    namespace :hybrid_radio, path: "hybrid" do
       root to: "static_pages#index"
       get  "radiodns"    => "radio_dns#index"
       get  "vis"         => "radio_vis#index"
       get  "vis/comet"   => "radio_vis#comet"
       get  "epg"         => "radio_epg#index"
       get  "epg/id/lsrfm.com/lsrfm/[:date]_PI.xml" => "radio_epg#lsrfm_epg"
    end

    get  "IbeforeE"       => "i_before_e#index"

    namespace :into_the_woods, path: "intothewoods" do
       root to: "static_pages#index"
       get "synopsis"     => "static_pages#synopsis"
       get "events"       => "static_pages#events"
       get "contact"      => "static_pages#contact"
    end

    get  "ip-tools"       => "ip_tools#index"
    resources :iphone_locations,  path: "iphone",     only: [:index, :show]
    get  "jewellery"      => "jewellery#index"
    post "jewellery"      => "jewellery#message"
    get  "jimmywales"     => "jimmy_wales#index"
    resources :locations,         path: "location",   only: [:index, :show]
    resources :local_tags,        path: "localtags",  except: [:new]
    get  "md5"            => "md5#index"
    namespace :mole do
      root to: "static_pages#index"
      get  "highscores/all"    => "high_scores#all"
      resources :high_scores,     path: "highscores", only: [:index, :create]
      resources :donations,       path: "purchase",   only: [:create]
      get  "addons/all"        => "addons#all"
      resources :addons,                              only: [:index]
      get  "total"    => "static_pages#total"
      get  "privacy"  => "static_pages#privacy"
      get  "facebook" => "static_pages#facebook"
    end
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

      get "listens/all"   => "listens#all",   as: "all_listens"
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

    get  "phonecalls/all" => "phonecalls#all",         as: "all_phonecalls"
    get  "phonecalls/stats" => "phonecalls#stats",     as: "phonecalls_stats"
    get  "phonecalls/contact/:contact" => "phonecalls#contact", as: "phonecall_contact"
    resources :phonecalls,                             only: [:index, :show, :create]

    get  "photos/all"     => "photos#all",             as: "all_photos"
    get  "photos/map"     => "photos#map",             as: "photos_map"
    get  "photos/stats"   => "photos#stats",           as: "photos_stats"
    resources :photos,                                 only: [:index, :show]

    get  "pdfy"           => "pdfy#index"
    post "pdfy"           => "pdfy#pdf"
    get  "qr"             => "qr#index"
    get  "reading"        => "reading#index"
    get  "realtime"       => "realtime#index"

    get  "running/all"    => "running_events#all",     as: "all_running_events"
    get  "running/map"    => "running_events#map",     as: "running_events_map"
    get  "running/stats"  => "running_events#stats",   as: "running_events_stats"
    resources :running_events,  path: "running"

    get  "speak"          => "speak#index"
    get  "samaritans"     => "samaritans#index"

    get  "sms/all"        => "text_messages#all",      as: "all_text_messages"
    get  "sms/stats"      => "text_messages#stats",    as: "text_message_stats"
    get  "sms/contact/:contact" => "text_messages#contact", as: "text_message_contact"
    resources :text_messages,   path: "sms",           only: [:index, :show]

    get  "stream"         => "stream#index"
    get  "sitemap"        => "static_pages#sitemap"

    get  "stuff/all"      => "projects#all",     as: "all_stuff"
    resources :projects,  path: "stuff",         as: "stuff",        except: [:create]
    resources :projects,  path: "stuff",         as: "new_stuff",    only:   [:create]

    get  "timestables"    => "times_tables#index"
    post "timestables"    => "times_tables#new"

    namespace :trains do
      root                                         to: 'static_pages#index'
      get  'schedules/id/:id',                     to: 'schedules#show_by_id',  as: 'schedule_id'
      get  'schedules/:uid',                       to: 'schedules#show_by_uid', as: 'schedule_uid'
      get  'schedules/:uid/:year/:month/:day',     to: 'schedules#show_by_uid', as: 'schedule_uid_and_date'
      get  'locations/map',                        to: 'locations#map',         as: 'locations_map'
      resources :locations,                                        only: [:index, :show]
      resources :journeys,            path: 'journeys',            except: [:new] do
        resources :journey_legs,      path: 'legs',                except: [:index]
      end
      resources :schedules,                                        only: [:index]
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

    namespace :west_side_story, path: "westsidestory" do
       root to: "static_pages#index"
       get "synopsis"     => "static_pages#synopsis"
       get "team"         => "static_pages#team"
       get "cast"         => "static_pages#cast"
       get "tickets"      => "static_pages#tickets"
       get "contact"      => "static_pages#contact"
    end

    get  "who"            => "static_pages#who"
    match '*url'          => 'application#error_404', via: [:get, :post, :patch, :delete]
  end

  root to: "static_pages#error_404", as: "error_404"
  match '*url'   => 'static_pages#error_404', via: [:get, :post, :patch, :delete]

end