Website::Application.routes.draw do

   #301s
  get "",              to: redirect("/api"),         constraints: { subdomain: 'api' }
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
  get "music/artist/:mbzid", to: redirect("/music/artists/%{mbzid}")

  root to: "static_pages#index"
  get "who"             => "static_pages#who", as: "who"
  get  "contact"        => "static_pages#contact",  as: "contact"
  get "todo" => "static_pages#todo", as: "todo"
  devise_for :users, path: "users", path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  as :user do
    get "login" => "devise/sessions#new", as: "new_session"
    get "logout" => "devise/sessions#destroy", as: "logout"
  end
  resources :projects, path: "stuff", as: "stuff"
  get  "blog/map"       => "blog_posts#map",    as: "blog_posts_map"
  resources :blog_posts, path: "blog"
  resources :blog_tags, path: "blog/tags", only: [:index, :show]
  get  "sitemap"        => "static_pages#sitemap",  as: "sitemap"
  get  "tweets/map"    => "tweets#map",            as: "tweets_map"
  get  "tweets/stats"  => "tweets#stats",          as: "tweets_stats"
  resources :tweets, only: [:index, :show]
  get  "facebook/map"   => "facebook_posts#map",    as: "facebook_posts_map"
  get  "facebook/stats" => "facebook_posts#stats",  as: "facebook_posts_stats"
  resources :facebook_posts, path: "facebook",    only: [:index, :show]
  resources :accounts, except: :show
  get  "episodes/stats" => "episodes#stats", as: "episodes_stats"
  resources :episodes,                           only: [:index, :show]
  resources :bank_transactions, path: "bank",    only: [:index]
  resources :locations, path: "location",        only: [:index, :show]
  resources :iphone_locations, path: "iphone",   only: [:index, :show]
  get  "sms/cloud"     => "text_messages#cloud", as: "text_message_cloud"
  get  "sms/stats"     => "text_messages#stats", as: "text_message_stats"
  get  "sms/contact/:contact" => "text_messages#contact", as: "text_message_contact"
  resources :text_messages, path: "sms",    only: [:index, :show]
  get  "photos/map"    => "photos#map",            as: "photos_map"
  get  "photos/stats"  => "photos#stats",          as: "photos_stats"
  resources :photos,                        only: [:index, :show]
  resources :drops,         path: "drop",   only: [:index, :create]
  resources :local_tags,    path: "localtags", except: [:new]
  get  "drop/:uri" => "drops#show", as: "drop"
  namespace :music do
    root to: "music#index"
    resources :dj_events, path: "dj"
    resources :artists, only: [:index, :show]
    get "listens/stats" => "listens#stats", as: "listen_stats"
    resources :listens, only: [:index, :show]
  end
  namespace :trains do
    root                                         to: 'static_pages#index'
    get  'schedules/update',                     to: 'schedules#update',      as: 'schedule_update'
    get  'schedules/id/:id',                     to: 'schedules#show_by_id',  as: 'schedule_id'
    get  'schedules/:uid',                       to: 'schedules#show_by_uid', as: 'schedule_uid'
    get  'schedules/:uid/:year/:month/:day',     to: 'schedules#show_by_uid', as: 'schedule_uid_and_date'
    resources :journeys,            path: 'journeys'
    resources :users,                                            only: [:show, :edit, :update]
    resources :sessions,                                         only: [:create]
    resources :schedules,                                        only: [:index]
    resources :locations,                                        only: [:index, :show]
    resources :operating_companies, path: 'operating-companies', only: [:index, :show]
    resources :power_types,         path: 'power-types',         only: [:index, :show]
    resources :categories,                                       only: [:index, :show]
  end
  get  "reading"        => "reading#index"
  get  "timestables"    => "times_tables#index"
  post "timestables"    => "times_tables#new"
  get  "samaritans"     => "samaritans#index"
  get  "molly"          => "molly#index"
  get  "qr"             => "qr#index"
  get  "pdfy"           => "pdfy#index"
  post "pdfy"           => "pdfy#pdf"
  get  "IbeforeE"       => "i_before_e#index"
  get  "wall"           => "wall#index"
  get  "analysis"       => "analysis#index"
  get  "musicwall"      => "musicwall#index"
  get  "friendstv"      => "friends_tv#index"
  get  "clock"          => "clock#index"
  get  "api"            => "api#index"
  get  "bbc-twitter"    => "bbc_twitter#index"
  get  "jimmywales"     => "jimmy_wales#index"
  get  "stream"         => "stream#index"
  get  "jewellery"      => "jewellery#index"
  post "jewellery"      => "jewellery#message"
  get  "nhtg11"         => "convicts#index"
  get  "speak"          => "speak#index"
  get  "browserwars"    => "browser_wars#index"
  get  "foebook"        => "static_pages#gone"
  get  "friendmap"      => "friendmap#index"
  get  "onradio/1"      => "on_radio#one"
  get  "onradio/1xtra"  => "on_radio#one_xtra"
  get  "onradio/2"      => "on_radio#two"
  get  "onradio/3"      => "on_radio#three"
  get  "onradio/6music" => "on_radio#six_music"
  get  "video"          => "video#index"
  match '*foo' => 'application#error_404', via: [:get, :post, :patch, :delete]
end
