Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/politique-de-confidentialite', to: 'pages#politique', as: 'politique'
  get '/mentions-legales', to: 'pages#mentions', as: 'mentions'

  devise_for :users
  root to: "pages#home"
  resources :hostels, only: [:show] do
    get 'booked_dates', on: :member, defaults: { format: :json }
    get 'calculate', on: :member, defaults: { format: :json }
    resources :bookings, only: [:create]
  end

  resources :bookings, only: [:show] do
    resources :contacts, only: :create
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
