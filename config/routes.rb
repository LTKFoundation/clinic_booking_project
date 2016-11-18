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
