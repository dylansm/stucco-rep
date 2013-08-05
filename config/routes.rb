Adoberep::Application.routes.draw do

  get 'dashboard' => 'dashboard#index', as: "dashboard"

  namespace :dashboard do

  end
    namespace :admin do
      resources :adobe_products
      resources :programs
      resources :schools
      resources :regions
      resources :users
      resources :notifications
      resources :links

      get 'program-users/:id' => 'programs#users', :as => "program_users"
      get 'program-managers/:id' => 'programs#managers', :as => "program_managers"
      get 'school-users/:id' => 'schools#users', :as => "school_users"

      get 'users/new/program/:program_id' => 'users#new', as: "new_user_for_program"
      patch 'programs/:id/add-existing-users' => 'programs#add_existing_users', as: "add_user_to_program"
      patch 'programs/:id/add-existing-managers' => 'programs#add_existing_managers', as: "add_manager_to_program"
      # AJAX
      put 'users/:id/suspend' => 'users#suspend'
      put 'users/:id/reactivate' => 'users#reactivate'
      put 'users/:id/current-program/:program_id' => 'users#current_program'
      put 'programs/:id/remove/:user_id' => 'programs#remove_user'
      get 'users/not-in-program/:program_id' => 'users#not_in_program'
      get 'users/not-admin-in-program/:program_id' => 'users#not_admin_in_program'
    end

  namespace :newsfeed do
    get '/' => 'posts#index'
    resources :posts do
      collection do
        get 'page/:page' => 'posts#index'
      end
      # AJAX
      resources :comments
      post :likes
    end
  end

  devise_for :users, :controllers => { 
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  get 'notifications' => 'admin/notifications#index', as: "notifications"
  get 'users/:id' => 'users#show', as: "user"
  get 'profile' => 'users#show'
  get 'members' => 'users#index', as: "members"
  patch 'users/:id' => 'users#create_post', as: "create_post"

  get 'pages/styles' => 'pages#styles'
  get 'pages/newsfeed-dev' => 'pages#newsfeed_dev'
  get 'pages/member-directory' => 'pages#member_directory'
  get 'pages/student-profile' => 'pages#student_profile'
  get 'pages/dashboard-dev' => 'pages#dashboard_dev'
  get 'pages/notification-center' => 'pages#notification_center'
  
  root 'pages#home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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

  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
