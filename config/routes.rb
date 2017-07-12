Rails.application.routes.draw do

  root 'products#index'
  get '/help' => 'user_stories#index'

  # Sessions

  get '/sessions/new' => 'sessions#new', as: 'new_session'
  post '/sessions' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'



  # Products
  get '/products' => 'products#index'

  get '/products/new' => 'products#new', as: 'new_product'
  post '/products' => 'products#create'

  get '/products/:id' => 'products#show', as: 'product'

  get '/products/:id/edit' => 'products#edit', as: 'edit_product'
  patch '/products/:id' => 'products#update'

  delete '/products/:id' => 'products#destroy'

  # Reviews
  get '/reviews' => 'reviews#index'

  get '/reviews/new' => 'reviews#new', as: 'new_review'
  post '/reviews' => 'reviews#create'

  get '/reviews/:id' => 'reviews#show', as: 'review'

  get '/reviews/:id/edit' => 'reviews#edit', as: 'edit_review'
  patch '/reviews/:id' => 'reviews#update'

  delete '/reviews/:id' => 'reviews#destroy'

  # Users

  get '/users' => 'users#index'

  get '/users/new' => 'users#new', as: 'new_user'
  post '/users' => 'users#create'

  get '/users/:id' => 'users#show', as: 'user'

  get '/users/:id/edit' => 'users#edit', as: 'edit_user'
  patch '/users/:id' => 'users#update'

  delete '/users/:id' => 'users#destroy'




end
