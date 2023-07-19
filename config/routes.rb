Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  get 'products/new'
  get 'products/create'
  get 'products/destroy'
  get 'categories/index'
  get 'categories/show'
  get 'categories/new'
  get 'categories/create'
  get 'categories/destroy'
  root 'static_pages#home'  
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get 'admin_dashboard/index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :categories do
    resources :products
  end
  get '/products', to: 'products#index_all', as: 'all_products'
end
