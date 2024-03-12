Rails.application.routes.draw do

  scope '(:locale)', locale: /en/ do
    root to: "pages#home"

    devise_for :users
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

    get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
    get '/politique-de-confidentialite', to: 'pages#politique', as: 'politique'
    get '/mentions-legales', to: 'pages#mentions', as: 'mentions'
    post '/contact', to: 'pages#contact', as: 'contact'
    post '/block_beds', to: 'bookings#block_beds', as: 'block_beds'

    resources :hostels, only: [:show] do
      get 'booked_dates', on: :member, defaults: { format: :json }
      get 'calculate', on: :member, defaults: { format: :json }
      resources :bookings, only: [:create]
    end

    resources :bookings, only: [:show, :destroy] do
      resources :contacts, only: :create
      resources :payments, only: :new
      get 'payments/success', to: 'payments#success'
      get 'payments/cancel', to: 'payments#cancel'
    end

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
