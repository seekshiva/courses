Courses::Application.routes.draw do

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
  # root :to => 'welcome#index'

  namespace :admin do
    resources :users
    resources :faculties
    resources :departments
    resources :courses do
      resources :term_departments, :term_faculties
      resources :classrooms
      resources :terms do 
        match "follow" => "terms#follow"
      end
      resources :class_topics
      get "new" => "courses#new"
      get "edit" => "courses#edit"
      get ":tab" => "courses#show"
    end
    resources :course_list_items, :course_references
    resources :books, :authors, :book_authors, :references
    match "switch_to" => "users#switch_to"
  end

  resources :users
  resources :departments
  
  resources :terms
  resources :courses
  resources :topics, :sections, :classrooms

  match "authenticate" => "home#authenticate"
  match "signout" => "home#signout"
  match "me" => "home#me"

  match "admin" => "admin/departments#index"

  match "login" => "home#index"

  match ":slug.json" => "#{:slug}s#index"
  match ":slug" => "#{:slug}s#index"
  #match ":slug" => "home#index"
  match ":slug/*route" => "home#index"




  root :to => 'home#index'
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
