Courses::Application.routes.draw do

  devise_for :users, :controllers => {
    registrations: "registrations",
    sessions:      "sessions"
  }
  
  devise_scope :user do
    post 'login',            to: 'sessions#create',    as: "login"
    get  'signout',          to: 'sessions#destroy',   as: "signout"
  end
  
  namespace :admin do
    resources :users
    resources :faculties
    resources :departments
    resources :documents
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
    resources :tests, controller: "test"
    post 'switch_to', to: 'users#switch_to'
  end

  resources :users
  resources :departments
  resources :profile
  
  resources :terms
  resources :courses
  resources :topics, :sections, :classrooms
  resources :topic_references
  resources :term_documents, :section_document, :topic_documents
  resources :subscriptions

  get 'admin',                to: 'admin/departments#index'
  get 'login',                to: 'home#index'
  get 'getting_started',      to: 'registration#new',       as: "getting_started"

  get 'download/:id(/:name)', to: 'download#show'

  post 'upload/:tab',         to: 'upload#create'

  get 'about' => 'high_voltage/pages#show', id: 'about'
  get 'contact-us' => 'high_voltage/pages#show', id: 'contact-us'
  get 'help' => 'high_voltage/pages#show', id: 'help'
  get "/pages/*id" => "high_voltage/pages#show", as: :page, format: false

  # get ':slug.json', to: "#{:slug}s#index"
  # get ':slug', to: "#{:slug}s#index"
  get ":slug" => "home#index"
  get ':slug/*route', to: 'home#index'

  root :to => 'home#index'
  
end
