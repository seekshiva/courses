Courses::Application.routes.draw do

  namespace :admin do
    resources :users
    resources :faculties
    resources :departments
    resources :courses do
      resources :term_departments, :term_faculties
      resources :classrooms
      resources :terms do 
        get 'follow', to: 'terms#follow'
      end
      resources :class_topics
      get "new" => "courses#new"
      get "edit" => "courses#edit"
      get ":tab" => "courses#show"
    end
    resources :books, :authors, :book_authors, :references
    get 'switch_to', to: 'users#switch_to'
  end

  resources :users
  resources :departments
  resources :profile
  
  resources :terms
  resources :courses
  resources :topics, :sections, :classrooms
  resources :term_documents, :section_document, :topic_document
  resources :subscriptions

  post 'upload/:tab', to: 'upload#create'
  post 'authenticate', to: 'home#authenticate'

  get 'me', to: 'home#me'
  get 'admin', to: 'admin/departments#index'
  get 'login', to: 'home#index'
  get 'signout', to: 'home#signout'

  get ':slug.json', to: "#{:slug}s#index"
  get ':slug', to: "#{:slug}s#index"
  #match ":slug" => "home#index"
  get ':slug/*route', to: 'home#index'

  root :to => 'home#index'
  
end
