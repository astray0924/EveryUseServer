WikiUse::Application.routes.draw do
  resources :users do
    resources :use_cases

    member do
      get 'favorited'
      get 'commented'
      get 'followeds'
      get 'followers'
    end
    
    collection do
      get 'stats_advanced'
      get 'stats'
    end
  end

  resources :user_sessions

  resources :use_cases do
    collection do
      get 'item'
      get 'purpose'
      get 'groups'
      get 'top'
      get 'divide_purpose_type'
      get 'stats_advanced'
    end
  end

  match 'stats/basic' => 'stats#stats'
  match 'stats/advanced' => 'stats#stats_advanced'

  # pagination
  # match ':controller/page/:page' => ':controller#index', :via => :get, :constraints => { :page => /\d+/ }
  # match ':controller/:action/page/:page' => ':controller#:action', :via => :get, :constraints => { :page => /\d+/ }

  # login/logout routing
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  # search
  match 'search' => 'search#index'

  # comments
  match 'comments' => 'comments#index', :via => :get
  match 'comments/list' => 'comments#list', :via => :get
  match 'favorite/add' => 'comments#favorite_add', :via => :post
  match 'favorite/delete' => 'comments#favorite_delete', :via => :post
  match 'fun/add' => 'comments#fun_add', :via => :post
  match 'fun/delete' => 'comments#fun_delete', :via => :post
  match 'metoo/add' => 'comments#metoo_add', :via => :post
  match 'metoo/delete' => 'comments#metoo_delete', :via => :post
  
  # relations
  match 'followings' => 'users_followings#index'
  match 'followings/create' => 'users_followings#create', :via => :post
  match 'followings/destroy' => 'users_followings#destroy', :via => :post

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'use_cases#index'

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
# match ':controller(/:action(/:id))(.:format)'
end
