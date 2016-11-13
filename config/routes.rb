Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  # Do not show all the users
  devise_for :doctors do
    resources :gigs, only: [ ] do
      resources :schedules, only: [] do
        # Route to new booking with schedule params and client id
        resources :bookings, only: [ :new, :create ]
      end
    end
  end

  resources :clients, only: [ :show, :create, :update, :destroy ]

  resources :clinics

  # Use with current_user
  resources :payment_method

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
end
