Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#home'  
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get 'admin_dashboard/index'
  #get 'login', to: 'sessions#new'
  #post 'login', to: 'sessions#create'
  

  get 'categories/:id/products', to: 'categories#products', as: 'categories_products'


  resources :categories 
  resources :products

resources :customers, only: [:new, :create]
  get 'login', to: 'customers#login_form'
  post 'login', to: 'customers#login'
  get '/signup', to: 'customers#new', as: 'signup'
  post '/signup', to: 'customers#create'
  get 'logout', to: 'customers#logout'
end
