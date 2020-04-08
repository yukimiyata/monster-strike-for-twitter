Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'
  resources :users, only: %i[new create]
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  resources :posts
  resources :recruiting_positions
  resources :joined_users
  resources :game_starts
  namespace :api do
    resources :joins
  end
end
