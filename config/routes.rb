Rails.application.routes.draw do
  get 'register', to: 'users#new', as: :register
  resources :users

  get 'welcome/index'
  root 'welcome#index'

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout
end
