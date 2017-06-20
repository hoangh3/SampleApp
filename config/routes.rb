Rails.application.routes.draw do

  root 'static_pages#home'

  get 'static_pages/home'

  get '/help', to: 'static_pages#help', as: 'helf'

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

  #Users
  resources :users

  # get '/users', to: 'users#index'

  get '/signup', to: 'users#new'

  # get 'users/:id', to: 'users#show'

  post '/signup', to: 'users#create'

  #Sessions
  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  #active account
  resources :account_activations, only: [:edit]

  #Password reset
  resources :password_resets, only: [:new, :create, :edit, :update]

  #micropost
  resources :microposts, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
