class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permit needed attribute for sign_up
    # Include uid, provider for FB, GG sign up
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit({ roles: [] }, :email, :password, :password_confirmation, :name, :uid, :provider)
    end

    # Permit attribute for editing
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit({ roles: [] }, :email, :current_password, :password, :password_confirmation, :name, :uid, :provider)
    end


    # Same as sign_in
  end
end
