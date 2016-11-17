Rails.application.routes.draw do

  namespace :admins do
    resources :users
  end
  devise_for :admins, controllers: {
    registrations: 'admins/registrations'
  }
  namespace :admins do
    get '/' => 'home#index', as: 'root'
    resources :users
    resources :doctors
    post 'doctors/:id/verify' => 'doctors#verify', as: 'doctor_verify'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  # Do not show all the users
  devise_for :doctors do
    resources :gigs, only: [ ] do
      resources :schedules, only: [] do
        # Route to new booking with schedule params and client id
        resources :bookings, only: [ :new, :create ]
      end
    end 
  end

	resources :doctors do
		collection do
			get 'add_clinic'
		end
		resources :gigs do
			resources :schedules do
			end
		end
	end

  resources :clients, only: [ :show, :create, :update, :destroy ]

  resources :clinics do
		collection do
			post 'current_loc'
		end
		collection do
			post 'add_clinic'
		end
		collection do
			get 'add_clinic_page'
		end
	end

  # Use with current_user
  resources :payment_method

  root 'home#index'
end
