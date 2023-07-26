Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#home'  
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get 'categories/:id/products', to: 'categories#products', as: 'categories_products'


  resources :categories 
  resources :products

  resources :customers, only: [:new, :create]
  get 'login', to: 'customers#login_form'
  post 'login', to: 'customers#login'
  get '/signup', to: 'customers#new', as: 'signup'
  post '/signup', to: 'customers#create'
  get 'logout', to: 'customers#logout'

  get '/cart', to: 'carts#index'

  post '/products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete '/products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart_product'
  patch '/products/update_quantity/:id', to: 'products#update_quantity', as: 'update_quantity_product'

end
