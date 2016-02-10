Rails.application.routes.draw do
  get 'points_data/new'

  get 'tours_points/new'

  get '/points/new', to: 'points#new', as: :new_point

  get '/points', to: 'points#index', as: :points

  post '/points', to: 'points#create'

  get '/points/show/:id', to: 'points#show', as: :point

  get '/data', to: 'data#index', as: :data

  get '/data/show/:id', to: 'data#show', as: :datum

  get '/data/new', to: 'data#new', as: :new_datum

  post '/data', to: 'data#create', as: :create_datum

  get '/data_audiences', to: 'data_audiences#new'

  get '/data_audiences/new', to: 'data_audiences#new', as: :new_data_audience

  post '/data_audiences', to: 'data_audiences#create'

  get '/audiences/show/:id', to: 'audiences#show', as: :audience

  get '/audiences', to: 'audiences#index', as: :audiences

  get '/audiences/new', to: 'audiences#new', as: :new_audience

  post '/audiences', to: 'audiences#create'

  get '/tours/show/:id', to: 'tours#show', as: :tour

  get '/tours/new', to: 'tours#new', as: :new_tour
  
  get '/tours', to: 'tours#index',as: :tours

  get '/tours_points', to: 'tours_points#new'

  get '/tours_points/new', to: 'tours_points#new', as: :new_tours_points

  post '/tours_points', to: 'tours_points#create'

  get '/points_data', to: 'points_data#new'

  get '/points_data/new', to: 'points_data#new', as: :new_points_data

  post '/points_data', to: 'points_data#create'

  get 'welcome/index'
  
  root 'welcome#index'

  devise_for :users, skip: :sessions, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy', as: 'logout'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
