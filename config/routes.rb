Rails.application.routes.draw do
  root 'tours#index'

  resources :users, except: [:new, :edit]
  resources :audiences, only: [:index, :create, :destroy]
  resources :points, except: [:new, :edit]
  resources :data, except: [:new, :edit]
  resources :data_audiences, only: [:create, :destroy]
  resources :feedback, only: [:create, :destroy]
  resources :tours, except: [:new, :edit]
  get '/tours/:id/pdf', to: 'tours#pdf', as: :tour_pdf

  resources :quiz, except: [:new, :edit]
  post '/quizzes/add_tour_quiz', to: 'quiz#add_tour_quiz', as: :add_tour_quiz
  delete '/quizzes/remove_tour_quiz/:id', to: 'quiz#remove_tour_quiz', as: :remove_tour_quiz

  resources :question, only: [:index, :create, :destroy]
  get '/quizzes/attempt_quiz/:id', to: 'public_quiz#attempt_quiz', as: :attempt_quiz
  post '/quizzes/submit_question', to: 'public_quiz#submit_question', as: :submit_question

  resources :answer, only: [:create, :destroy]
  post '/answers/:id', to: 'answer#make_correct', as: :answer_make_correct

  # Tours Points
  post '/tour_points', to: 'tours_points#create', as: :create_tour_point
  delete '/tours_points/:id', to: 'tours_points#destroy', as: :delete_tour_point
  post '/tour_points/increase_rank/:id',to: 'tours_points#increase_rank', as: :increase_tour_point
  post '/tour_points/decrease_rank/:id',to: 'tours_points#decrease_rank', as: :decrease_tour_point

  # Points Data
  post '/point_data', to: 'points_data#create', as: :create_point_datum
  delete '/points_data/:id', to: 'points_data#destroy', as: :delete_points_data
  post '/points_data/increase_rank/:id',to: 'points_data#increase_rank', as: :increase_point_datum
  post '/points_data/decrease_rank/:id',to: 'points_data#decrease_rank', as: :decrease_point_datum

  # Session handling
  get 'register', to: 'users#new', as: :register
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout

  #Password reset
  get 'password_reset', to: 'password_reset#new', as: :password_reset
  post 'password_reset', to: 'password_reset#create', as: :add_password_reset
  get 'password_reset/:temporarypassword/activate/', to: 'password_reset#activate', as: :activate_password_reset
  # Tour sessions
  post '/tour_sessions', to: 'tour_sessions#create', as: :create_tour_session
  patch '/tour_sessions/:id', to: 'tour_sessions#update', as: :update_tour_session
  delete '/tour_sessions/:id', to: 'tour_sessions#destroy', as: :delete_tour_session
  post '/tour_sessions/email/:id', to: 'tour_sessions#send_email', as: :tour_session_invitation

  # API
  namespace :api do
    get ':access_key/:passphrase', to: 'api#single_tour'
  end
end
