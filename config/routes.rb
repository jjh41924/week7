Rails.application.routes.draw do

  root 'products#index'

  get '/products' => 'products#index'

  get '/products/new' => 'products#new'

  get '/products/:id' => 'products#show'

  get '/products/:id/edit' => 'products#edit'


  get '/help' => 'user_stories#index'

end
