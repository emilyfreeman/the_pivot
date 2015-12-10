Rails.application.routes.draw do
  root to: "pages#home"

  namespace :platform do
    resources :dashboard, only: [:index]
  end
  # resources instead of namespace? pass module as flag
  namespace :stores, path: ":store", as: :store do
    resources :dashboard, only: [:show, :index]
    resources :items,  only: [:show, :index]
    resources :orders, only: [:show, :index, :update]
    resources :admins, only: [:new, :create, :destroy]
  end

  resources :categories, only: [:index, :show], param: :slug
  resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy], param: :slug
  resources :cart_items, only: [:create, :index, :destroy, :update]
  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :create, :show, :new]
  resources :stores, only: [:index, :show, :new, :create, :edit, :update]

  get '/farmers', to: 'stores#index'

  get '/about', to: 'pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'
  get '/cart', to: 'cart_items#index'
  get '/:store', to: 'stores#show'
end
