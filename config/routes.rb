Rails.application.routes.draw do
  get "habits/index"
  get "habits/new"
  get "habits/edit"
  get "balance/index"
  get "meetings/index"
  get "meetings/new"
  get "meetings/create"
  get "meetings/edit"
  get "meetings/update"
  get "meetings/destroy"
  get "index/new"
  get "index/create"
  get "index/edit"
  get "index/update"
  get "index/destroy"
  get "notes/index"
  get "notes/create"
  get "expenses/index"
  get "expenses/create"
  get "dashboard/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "dashboard#index"
  resources :users, only: [:new, :create]

  get  "/login",  to: "sessions#new"
  post "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "dashboard#index"
  get "/balance", to: "balance#index"

  get  "/analytics", to: "analytics#index"
  get "/analytics/result", to: "analytics#show", as: :analytics_result
  #post "/analytics", to: "analytics#show"


  #post "/balance", to:
  resources :expenses, only: [:index, :create, :edit, :update, :destroy]
  resources :notes, only: [:index, :create, :edit, :update, :destroy]
  resources :meetings
  resources :categories
  resources :targets
  resources :incomes
  resources :expenditures
  resources :contacts
  resources :uploaded_files
  resources :habits do
    collection do
      get :calendar
    end
  end
  get "/habits_dashboard", to: "habits#dashboard", as: :habits_dashboard
  resources :global_habits
  resources :daily_habits do
    member do
      patch :toggle_complete
    end
  end
  #tracking
end
