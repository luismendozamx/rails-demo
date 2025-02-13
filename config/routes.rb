Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :v1 do
    post "webhooks/ghost", to: "webhooks#ghost"
  end

  get "/blog", to: "blog#index", as: :blog
  get "/blog/:slug", to: "blog#show", as: :blog_post
end
