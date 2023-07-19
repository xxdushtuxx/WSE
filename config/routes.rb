Rails.application.routes.draw do
  root 'static_pages#home'  
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  get 'admin_dashboard/index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
