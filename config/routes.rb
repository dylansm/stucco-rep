Adoberep::Application.routes.draw do
  # pages
  #get 'manage-users' => 'pages#manage_users'
  namespace :dashboard do
    get 'program-users/:id' => 'admin/users#program_users', :as => "program_users"
    get 'program-managers/:id' => 'admin/users#program_managers', :as => "program_managers"
    get 'school-users/:id' => 'admin/users#school_users', :as => "school_users"

    namespace :admin do
      resources :adobe_products
      resources :programs
      resources :schools
      resources :regions
      resources :users
      put 'users/:id/suspend' => 'users#suspend'
      put 'users/:id/reactivate' => 'users#reactivate'
    end
  end

  # users
  devise_for :users, :controllers => { 
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  get 'users/:id' => 'users#show', :as => "user"
  get 'profile' => 'users#show'

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
