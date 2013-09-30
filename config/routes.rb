Website::Application.routes.draw do

  root to: "static_pages#index"
  get "who" => "static_pages#who", as: "who"
  get  "contact"        => "static_pages#contact",  as: "contact"

  get  "blog/map"       => "blog_posts#map",    as: "blog_post_map"
  resources :blog_posts, path: "blog"
  resources :blog_tags, path: "blog/tags", only: [:index, :show]
end
