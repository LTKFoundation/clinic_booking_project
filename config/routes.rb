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
    resources :clinics
    post 'doctors/:id/verify' => 'doctors#verify', as: 'doctor_verify'
    post 'clinics/:id/verify' => 'clinics#verify', as: 'clinic_verify'
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

  
  resources :bookings, only: [ :show, :update, :create ]
  resources :patients

  resources :doctors do
<<<<<<< 13fccfeeb58ceab0180ab46c81d84aeae790ed8d
=======
    resources :articles do
    end            
>>>>>>> Add city, district to clinics; Upload image; Articles
    collection do
      get 'add_clinic'
    end
    resources :gigs do
      get 'client_view' => 'clients#view_gig'
      get 'doctor_view' => 'gigs#booking_manage'
    end
<<<<<<< 13fccfeeb58ceab0180ab46c81d84aeae790ed8d
    resources :comments
=======
>>>>>>> Add city, district to clinics; Upload image; Articles
  end

  resources :clients, only: [ :show, :create, :update, :destroy ]

  resources :clinics do
<<<<<<< 13fccfeeb58ceab0180ab46c81d84aeae790ed8d
		collection do
			post 'current_loc'
		end
		collection do
			post 'add_clinic'
		end
		collection do
			get 'add_clinic_page'
      get 'add_clinic_page_client'
		end
	end
=======
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
>>>>>>> Add city, district to clinics; Upload image; Articles

  resources :carts do
    member do
      get 'show_receipt'
    end
  end

  # Use with current_user
  resources :payment_method

  root 'home#index'
end
