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
    resources :link_types
    delete 'link_types' => 'link_types#destroy', as: "destroy_link_type"

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
    post 'ratings/post/:id/:rating' => 'ratings#rate_post'
    patch 'ratings/post/:id/:rating' => 'ratings#update_rated_post'
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
  post 'dismiss-notification/:id' => 'admin/notifications#dismiss'
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

  get 'link/:id' => 'visited_links#link', as: "link"
  get 'link/:id/:social_id' => 'visited_links#social_link', as: "link_on_social"
  
  root 'pages#home'
  
end
