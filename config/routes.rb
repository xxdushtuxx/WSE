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
  delete '/products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  patch '/products/update_quantity/:id', to: 'products#update_quantity', as: 'update_quantity_product'

  patch '/customers/:id/update_address', to: 'customers#update_address', as: :update_address

  post '/orders/address', to: 'orders#non_logged_in_address', as: :non_user_address

  post '/checkout', to: 'orders#checkout', as: 'checkout'
  get '/orders/index', to: 'orders#index', as: 'invoice'

  #post '/proceed_to_payment', to: 'orders#proceed_to_payment', as: 'proceed_to_payment'
  #get '/orders/:id/payment', to: 'orders#payment', as: 'payment'
  get '/proceed_to_payment', to: 'orders#proceed_to_payment', as: :proceed_to_payment
  get '/order_success/:id', to: 'orders#order_success', as: :order_success
  get '/order_cancel/:id', to: 'orders#order_cancel', as: :order_cancel

  get '/my_profile', to: 'customers#show', as: 'my_profile'

  resources :contact_pages, only: [:show]
  resources :about_pages, only: [:show]

  
end
