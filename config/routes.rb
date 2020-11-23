Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  resources :users, only: %w[edit update] do
    member do
      get :following, :followers
    end
  end
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  get '/test-user1', to: 'user_sessions#test_user_1'
  get '/test-user2', to: 'user_sessions#test_user_2'
  delete '/logout', to: 'user_sessions#destroy'
  resources :posts, only: %w[index show new create]
  resources :joined_users, only: %w[create destroy]
  get '/now_join', to: 'joined_users#now_join'

  resources :game_starts, only: :show do
    member do
      get 'starting'
    end
  end

  namespace :api do
    resources :joins, only: :index
    resources :posts, only: :index
  end
  resources :relationships, only: %w[index create destroy]
  resources :blacklists, only: %w[create destroy]

  get '/terms', to: 'static_pages#terms'
  get '/explanation', to: 'static_pages#explanation'

  namespace :admin do
    root 'dashboards#top'
    get '/login', to: 'user_sessions#new'
    post '/login', to: 'user_sessions#create'
    delete '/logout', to: 'user_sessions#destroy'
    resources :posts, only: %w[index destroy]
    resources :users, only: :index
  end
end
