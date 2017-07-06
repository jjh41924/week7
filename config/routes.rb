Rails.application.routes.draw do

  root 'products#index'

  get '/products' => 'products#index'
  post '/products' => 'products#create'

  get '/products/new' => 'products#new'

  get '/products/:id' => 'products#show'

  get '/products/:id/edit' => 'products#edit'

  delete '/products/:id' => 'products#destroy'

  get '/help' => 'user_stories#index'

end
