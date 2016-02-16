Rails.application.routes.draw do
  get 'tours_audiences/new'

  # Point Data
  get 'points_data/new'

  delete '/points_data/:id', to: 'points_data#destroy', as: :delete_points_data

  get '/points_data/:id', to: 'points_data#edit', as: :edit_points_datum

  patch '/points_data/:id',to: 'points_data#update', as: :update_points_datum

  # Points
  get 'tours_points/new'

  get '/points/new', to: 'points#new', as: :new_point

  get '/points', to: 'points#index', as: :points

  get '/points/:id/edit', to: 'points#edit', as: :edit_point

  patch '/points/:id', to: 'points#update', as: :update_point

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

  delete '/tours/:id', to: 'tours#destroy', as: :delete_tour

  get '/tours/:id/edit', to: 'tours#edit',as: :edit_tour

  post '/tours', to: 'tours#create'

  patch '/tours/:id', to: 'tours#update', as: :update_tour

  # Tours Points
  get '/tours_points', to: 'tours_points#new'

  get '/tours_points/new', to: 'tours_points#new', as: :new_tours_points

  post '/tour_points', to: 'tours_points#create'

  delete '/tours_points/:id', to: 'tours_points#destroy', as: :delete_tours_points

  # Points Data
  get '/points_data', to: 'points_data#new', as: :new_points_data

  post '/point_data', to: 'points_data#create'

    # Tours Audiences

  get '/tours_audiences', to: 'tours_audiences#new'

  get '/tours_audiences/new', to: 'tours_audiences#new', as: :new_tours_audience

  post '/tour_audiences', to: 'tours_audiences#create'

  # API Access
  get '/api/:access_key/fetch/:table_name',to: 'api#fetch'

    #General

  get 'welcome/index'

  root 'welcome#index'

  get 'welcome/index'

    #Session handling
  get 'register', to: 'users#new', as: :register
  resources :users
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout

  # Users
  get '/users', to: 'users#index', as: :all_users
  get '/users/:id', to: 'users#show', as: :profile
  post '/users/:id', to: 'users#update', as: :update_profile

  # API
  namespace :api do
    get ':access_key/audiences', to: 'api#audiences'
    get ':access_key/tours', to: 'api#tours'
    get ':access_key/points', to: 'api#points'
    get ':access_key/data', to: 'api#data'
    get ':access_key/tour_points', to: 'api#tour_points'
    get ':access_key/point_data', to: 'api#point_data'
    get ':access_key/data_audiences', to: 'api#data_audiences'
  end
end
