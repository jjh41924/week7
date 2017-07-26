Rails.application.routes.draw do

  root 'products#index'
  get '/help' => 'user_stories#index'

  # Sessions

  get '/sessions/new' => 'sessions#new', as: 'new_session'
  post '/sessions' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'


  resources :products
  resources :reviews
  resources :users
  resources :orders


end
