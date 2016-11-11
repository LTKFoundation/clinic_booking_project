Rails.application.routes.draw do
  devise_for :users

  # Do not show all the users
  resources :doctors, only: [ :show, :create, :update, :destroy ]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
end
