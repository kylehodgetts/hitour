Rails.application.routes.draw do
  root 'tours#index'
  get 'tours_audiences/new'

  resources :audiences, only: [:index, :create, :destroy]
  resources :points, except: [:new, :edit]
  resources :data, except: [:new, :edit]
  resources :data_audiences, only: [:create, :destroy]
  resources :tours, except: [:new, :edit]
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
  get 'password_reset/:temporarypassword/activate/', to: 'password_reset#activate', as: :activate_password_reset
  # Tour sessions
  post '/tour_sessions', to: 'tour_sessions#create', as: :create_tour_session
  patch '/tour_sessions/:id', to: 'tour_sessions#update', as: :update_tour_session
  delete '/tour_sessions/:id', to: 'tour_sessions#destroy', as: :delete_tour_session
  post '/tour_sessions/email/:id', to: 'tour_sessions#send_email', as: :tour_session_invitation

  delete '/feedback/:id', to: 'feedback#destroy', as: :delete_feedback
  post '/feedback', to: 'feedback#create', as: :create_feedback

  # Quiz
  post '/quizzes', to: 'quiz#create', as: :create_quiz
  patch '/quizzes/:id', to: 'quiz#update', as: :update_quiz
  delete '/quizzes/:id', to: 'quiz#destroy', as: :delete_quiz
  get '/quizzes/show/:id', to: 'quiz#show', as: :quiz
  get '/quizzes', to: 'quiz#index', as: :quizzes
  post '/quizzes/add_tour_quiz', to: 'quiz#add_tour_quiz', as: :add_tour_quiz
  delete '/quizzes/remove_tour_quiz/:id', to: 'quiz#remove_tour_quiz', as: :remove_tour_quiz


  get '/quizzes/attempt_quiz/:id', to: 'public_quiz#attempt_quiz', as: :attempt_quiz
  post '/quizzes/submit_question', to: 'public_quiz#submit_question', as: :submit_question

  # Question
  post '/questions', to: 'question#create', as: :create_question
  delete '/questions/:id', to: 'question#destroy', as: :delete_question
  get '/questions', to: 'question#index', as: :questions

  # Answer
  post '/answers', to: 'answer#create', as: :create_answer
  delete '/answers/:id', to: 'answer#destroy', as: :delete_answer
  post '/answers/:id', to: 'answer#make_correct', as: :answer_make_correct

  # API
  namespace :api do
    get ':access_key/:passphrase', to: 'api#single_tour'
  end
end
