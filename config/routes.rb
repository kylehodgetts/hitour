Rails.application.routes.draw do
  root 'tours#index'
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
  get '/points/show/:id', to: 'points#show', as: :point
  patch '/points/:id', to: 'points#update', as: :update_point
  post '/points', to: 'points#create', as: :create_point
  delete '/points/:id', to: 'points#destroy', as: :delete_point


  # Data
  get '/data', to: 'data#index', as: :data
  get '/data/show/:id', to: 'data#show', as: :datum
  get '/data/new', to: 'data#new', as: :new_datum
  get '/data/:id/edit', to: 'data#edit', as: :edit_datum
  post '/data', to: 'data#create', as: :create_datum
  patch '/data/:id', to: 'data#update', as: :update_datum
  delete '/data/:id', to: 'data#destroy', as: :delete_datum

  # Data Audiences
  get '/data_audiences', to: 'data_audiences#new'
  get '/data_audiences/new', to: 'data_audiences#new', as: :new_data_audience
  post '/data_audiences', to: 'data_audiences#create'

  # Audiences
  get '/audiences', to: 'audiences#index', as: :audiences
  post '/audiences', to: 'audiences#create', as: :create_audience
  delete '/audiences/:id', to: 'audiences#destroy', as: :delete_audience

  # Tours
  get '/tours', to: 'tours#index',as: :tours
  get '/tours/show/:id', to: 'tours#show', as: :tour
  get '/tours/new', to: 'tours#new', as: :new_tour
  delete '/tours/:id', to: 'tours#destroy', as: :delete_tour
  get '/tours/:id/edit', to: 'tours#edit',as: :edit_tour
  post '/tours', to: 'tours#create', as: :create_tour
  patch '/tours/:id', to: 'tours#update', as: :update_tour

  # Tours Points
  get '/tours_points', to: 'tours_points#new'
  get '/tours_points/new', to: 'tours_points#new', as: :new_tours_points
  post '/tour_points', to: 'tours_points#create', as: :create_tour_point
  delete '/tours_points/:id', to: 'tours_points#destroy', as: :delete_tour_point

  # Points Data
  resources :points_data, only: [:new, :create]
  get '/points_data', to: 'points_data#new', as: :new_points_data
  post '/point_data', to: 'points_data#create'

  # Tours Audiences
  get '/tours_audiences', to: 'tours_audiences#new'
  get '/tours_audiences/new', to: 'tours_audiences#new', as: :new_tours_audience
  post '/tour_audiences', to: 'tours_audiences#create'

  #Session handling
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout

  # Users
  get '/users', to: 'users#index', as: :users
  get '/users/:id', to: 'users#show', as: :user
  post '/users', to: 'users#create', as: :new_user
  patch '/users/:id', to: 'users#update', as: :update_profile
  delete '/users/:id', to: 'users#destroy', as: :delete_user

  # API
  namespace :api do
    get ':access_key/users', to: 'api#users'
    get ':access_key/audiences', to: 'api#audiences'
    get ':access_key/tours', to: 'api#tours'
    get ':access_key/points', to: 'api#points'
    get ':access_key/data', to: 'api#data'
    get ':access_key/tour_points', to: 'api#tour_points'
    get ':access_key/point_data', to: 'api#point_data'
    get ':access_key/data_audiences', to: 'api#data_audiences'
  end
end
