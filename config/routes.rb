Rails.application.routes.draw do
  # Point Data
  get 'points_data/new'

  delete '/points_data/:id', to: 'points_data#destroy', as: :delete_points_data
  # Points

  get 'tours_points/new'

  get '/points/new', to: 'points#new', as: :new_point

  get '/points', to: 'points#index', as: :points

  post '/points', to: 'points#create'

  get '/points/show/:id', to: 'points#show', as: :point

  # Data

  get '/data', to: 'data#index', as: :data

  get '/data/show/:id', to: 'data#show', as: :datum

  get '/data/new', to: 'data#new', as: :new_datum

  post '/data', to: 'data#create', as: :create_datum

  get '/data/:id/edit', to: 'data#edit', as: :edit_datum

  patch '/data/:id', to: 'data#update', as: :update_datum

  delete '/data/:id', to: 'data#destroy', as: :delete_datum

  # Data Audiences

  get '/data_audiences', to: 'data_audiences#new'

  get '/data_audiences/new', to: 'data_audiences#new', as: :new_data_audience

  post '/data_audiences', to: 'data_audiences#create'

  # Audiences

  get '/audiences/show/:id', to: 'audiences#show', as: :audience

  get '/audiences', to: 'audiences#index', as: :audiences

  get '/audiences/new', to: 'audiences#new', as: :new_audience

  post '/audiences', to: 'audiences#create'

  get '/audiences/:id/edit', to: 'audiences#edit', as: :edit_audience

  patch '/audiences/:id', to: 'audiences#update'

  # Tours
  get '/tours', to: 'tours#index',as: :tours

  get '/tours/show/:id', to: 'tours#show', as: :tour

  get '/tours/new', to: 'tours#new', as: :new_tour

  post '/tours', to: 'tours#create'

  get '/tours_points', to: 'tours_points#new'

  get '/tours_points/new', to: 'tours_points#new', as: :new_tours_points

  post '/tour_points', to: 'tours_points#create'

  get '/points_data', to: 'points_data#new', as: :new_points_data

  post '/point_data', to: 'points_data#create'

  get 'welcome/index'
  
  root 'welcome#index'
  get 'welcome/index'

  get 'register', to: 'users#new', as: :register
  resources :users

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout
end
