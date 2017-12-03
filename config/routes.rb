Rails.application.routes.draw do

  root 'static_pages#home', as: 'home'

  get 'password_resets/new'

  get 'password_resets/edit'

  resources :tags

  resources :usuario_avalia_jogos

  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/help'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]

  resources :users do 

     resources :wishlists

  end
  
  resources :jogos do

    resources :reviews, only: [:create, :new]

  end

  post '/add_jogo_to_wishlist/:wishlist_id' => 'users#add_jogo_to_wishlist', :as => 'add_jogo_to_wishlist'
  post '/create_wishlist' => 'users#create_wishlist', :as => 'create_wishlist'

end
