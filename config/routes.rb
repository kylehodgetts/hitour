Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'

  get 'register', to: 'users#new', as: :register
  resources :users

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout
end
