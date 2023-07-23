Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#home'  
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get 'admin_dashboard/index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'categories/:id/products', to: 'categories#products', as: 'categories_products'


  resources :categories 
  resources :products
  #get '/products', to: 'products#index_all', as: 'all_products'
=begin
  get 'products/sale', to: 'products#sale', as: 'products_on_sale'
  get 'products/new_products', to: 'products#new_products', as: 'products_new_products'
  get 'products/recently_updated', to: 'products#recently_updated', as: 'products_recently_updated'
=end
end
