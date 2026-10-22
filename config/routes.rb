require 'sidekiq/web'

Rails.application.routes.draw do
  mount JobApplicationsMcp.app => "/mcp"
  mount Sidekiq::Web => "/sidekiq"
  resources :my_offers
  resources :email_messages
  resources :auto_suggestions
  devise_for :users, :skip => [:registrations]

  devise_scope :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
    delete 'logout', to: 'users/sessions#destroy', as: :logout
    get '/profile', to: 'users#show', as: :user_profile # Add this line for the profile page
    get '/enable_2fa', to: 'users#enable_2fa', as: :enable_2fa # Add this line for the 2FA page
    put '/disable_2fa', to: 'users#disable_2fa', as: :disable_2fa # Add this line for the 2FA page
  end

      as :user do
        get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
        put 'users' => 'devise/registrations#update', :as => 'user_registration'
      end
  mount Ckeditor::Engine => '/ckeditor'
  scope :auth do
    resources :users, only: [:show, :update] do 
      get :search, on: :collection
    end
  end
  resources :reflections
  resources :shift_shames
  resources :learnings
  resources :frustrations
  resources :stories
  resources :memories
  resources :interview_cheat_sheets
  resources :flashcards
  resources :englishes
  get "search/*word", to: "englishes#search"
  get "search_for_fight_club/*word", to: "englishes#search_for_fight_club"
  resources :tasks
  resources :weekly_plans
  resources :job_applications
  resources :comments
  root to: "topics#index"

  resources :topics
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
