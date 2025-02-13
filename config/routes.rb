Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "/blog", to: "blog#index", as: :blog
  get "/blog/:slug", to: "blog#show", as: :blog_post
end
