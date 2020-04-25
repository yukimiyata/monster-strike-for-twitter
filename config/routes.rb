Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  post "oauth/callback", to: "oauths#callback"
  get 'oauth/callback', to: 'oauths#callback'
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  resources :users, only: %i[new create edit update] do
    member do
      get :following, :followers
    end
  end
    get '/login', to: 'user_sessions#new'
    post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  resources :posts
  resources :joined_users
  get '/now_join', to: 'joined_users#now_join'
  resources :game_starts do
    member do
      get 'starting'
    end
  end
  namespace :api do
    resources :joins
    resources :posts
  end
  resources :relationships, only: %w[index create destroy]
  resources :blacklists, only: %w[create destroy]
  namespace :admin do
    root 'dashboards#top'
    get '/login', to: 'user_sessions#new'
    post '/login', to: 'user_sessions#create'
    delete '/logout', to: 'user_sessions#destroy'
    resources :posts, only: %w[index destroy]
    resources :users, only: :index
  end
end
