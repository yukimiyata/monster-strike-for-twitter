Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :users, only: %i[new create] do
    member do
      get :following, :followers
    end
  end
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  resources :posts
  resources :joined_users
  resources :game_starts
  namespace :api do
    resources :joins
    resources :posts
  end
  resources :relationships, only: %w[index create destroy]
  resources :blacklists, only: %w[create destroy]
end
