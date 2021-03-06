Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

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

  get 'uber_doctors' => 'drlocs#user_view'

  resources :drlocs do
    collection do
      get 'before_start' => 'drlocs#before_start'
      get 'before_simulator' => 'drlocs#before_simulator'
      get 'simulator' => 'drlocs#simulator'
    end 
  end

  # resources :bookings, only: [ :show, :update, :create ]
  resources :bookings do
    get 'view_checked' => 'bookings#show_checked'
    get 'create_patient' => 'bookings#create_patient'
    get 'user_review' => 'bookings#user_review'
    get 'add_prescription' => 'bookings#add_prescription'
  end
  resources :patients do
    get 'share_patient_info' => 'patients#share_info'
    get 'add_doctor' => 'patients#add_doctor'
    get 'remove_doctor' => 'patients#remove_doctor'
    get 'doctor_view' => 'patients#doctor_view'
  end

  resources :doctors do
    collection do
      get 'add_clinic'
    end
    resources :gigs do
      get 'client_view' => 'clients#view_gig'
      get 'doctor_view' => 'gigs#booking_manage'
    end
    resources :comments
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
      get 'add_clinic_page_client'
		end
	end

  resources :carts do
		member do
			get 'show_receipt'
		end
	end

  get 'view_my_booking' => 'clients#view_my_booking'
  # Use with current_user
  resources :payment_method

  root 'clinics#index'
  # root 'home#index'
end
