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
  get "who" => "static_pages#who", as: "who"
  get  "contact"        => "static_pages#contact",  as: "contact"
  resources :projects, path: "stuff", as: "stuff"
  get  "blog/stats"       => "blog#map",    as: "blog_post_stats"
  get  "blog/map"       => "blog_posts#map",    as: "blog_post_map"
  resources :blog_posts, path: "blog"
  resources :blog_tags, path: "blog/tags", only: [:index, :show]
  get  "tweets/stats"       => "tweets#map",    as: "tweets_stats"
  get  "tweets/map"       => "tweets#map",    as: "tweets_map"
  resources :tweets, only: [:index, :show]
  get  "photos/map"    => "photos#map",            as: "photos_map"
  get  "photos/stats"  => "photos#stats",          as: "photos_stats"
  resources :episodes,                           only: [:index, :show]
  resources :photos,                        only: [:index, :show]
  resources :locations, path: "location",        only: [:index, :show]
  namespace :music do
    root to: "music#index"
    resources :dj_events, path: "dj"
    resources :artists, only: [:index, :show]
    get "listens/stats" => "listens#stats", as: "listen_stats"
    resources :listens, only: [:index, :show]
  end
  match '*foo' => 'application#error_404', via: [:get, :post]
end
