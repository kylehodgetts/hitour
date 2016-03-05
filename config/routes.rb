Rails.application.routes.draw do
  root 'tours#index'
  get 'tours_audiences/new'

  # Points
  get '/points', to: 'points#index', as: :points
  get '/points/show/:id', to: 'points#show', as: :point
  patch '/points/:id', to: 'points#update', as: :update_point
  post '/points', to: 'points#create', as: :create_point
  delete '/points/:id', to: 'points#destroy', as: :delete_point

  # Data
  get '/data', to: 'data#index', as: :data
  get '/data/show/:id', to: 'data#show', as: :datum
  post '/data', to: 'data#create', as: :create_datum
  patch '/data/:id', to: 'data#update', as: :update_datum
  delete '/data/:id', to: 'data#destroy', as: :delete_datum
  get '/data/compress_form', to: 'data#compress_form', as: :compress_form
  post '/data/video', to: 'data#compress_video', as: :compress_video

  # Data Audiences
  get '/data_audiences', to: 'data_audiences#new'
  get '/data_audiences/new', to: 'data_audiences#new', as: :new_data_audience
  post '/data_audiences', to: 'data_audiences#create', as: :create_datum_audience
  delete '/data_audiences/:id', to: 'data_audiences#destroy', as: :delete_datum_audience

  # Audiences
  get '/audiences', to: 'audiences#index', as: :audiences
  post '/audiences', to: 'audiences#create', as: :create_audience
  delete '/audiences/:id', to: 'audiences#destroy', as: :delete_audience

  # Tours
  get '/tours', to: 'tours#index', as: :tours
  get '/tours/show/:id', to: 'tours#show', as: :tour
  delete '/tours/:id', to: 'tours#destroy', as: :delete_tour
  post '/tours', to: 'tours#create', as: :create_tour
  patch '/tours/:id', to: 'tours#update', as: :update_tour
  get '/tours/:id/pdf', to: 'tours#pdf', as: :tour_pdf

  # Tours Points
  post '/tour_points', to: 'tours_points#create', as: :create_tour_point
  post '/tour_points/increase_rank/:id',to: 'tours_points#increase_rank', as: :increase_tour_point
  post '/tour_points/decrease_rank/:id',to: 'tours_points#decrease_rank', as: :decrease_tour_point
  delete '/tours_points/:id', to: 'tours_points#destroy', as: :delete_tour_point

  # Points Data
  post '/point_data', to: 'points_data#create', as: :create_point_datum
  delete '/points_data/:id', to: 'points_data#destroy', as: :delete_points_data
  patch '/points_data/:id', to: 'points_data#update', as: :update_points_datum
  post '/points_data/increase_rank/:id',to: 'points_data#increase_rank', as: :increase_point_datum
  post '/points_data/decrease_rank/:id',to: 'points_data#decrease_rank', as: :decrease_point_datum

  # Tours Audiences
  get '/tours_audiences/new', to: 'tours_audiences#new', as: :new_tours_audience
  post '/tour_audiences', to: 'tours_audiences#create'

  # Session handling
  get 'register', to: 'users#new', as: :register
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout

  # Users
  resources :users
  get '/users', to: 'users#index'
  post '/users', to: 'users#create', as: :create_user
  post '/users/:id', to: 'users#update', as: :update_profile
  delete '/users/:id', to: 'users#destroy', as: :delete_user

  #Password reset
  get 'password_reset', to: 'password_reset#new', as: :password_reset
  post 'password_reset', to: 'password_reset#create', as: :add_password_reset

  # Tour sessions
  post '/tour_sessions', to: 'tour_sessions#create', as: :create_tour_session
  patch '/tour_sessions/:id', to: 'tour_sessions#update', as: :update_tour_session
  delete '/tour_sessions/:id', to: 'tour_sessions#destroy', as: :delete_tour_session

  # API
  namespace :api do
    get ':access_key/:passphrase', to: 'api#single_tour'
  end
end
