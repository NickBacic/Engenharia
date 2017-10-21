Rails.application.routes.draw do


  resources :usuario_avalia_jogos
  
  root 'static_pages#home', as: 'home'

  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/help'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'

  get '/reviews/new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :reviews
  
  resources :jogos do
    resources :reviews
  end


end
