class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource
  helper_method :doctor_gig

  # def require_ssl
  #   redirect_to :protocol => "https://" unless (request.ssl? or local_request?)  
  # end

  def authenticate_user_or_doctor
    unless current_user || current_doctor
      flash[:alert] = 'Xin hãy đăng nhập trước!'
      redirect_to user_session_path
    end
  end

  def doctor_gig
    if current_doctor
      @gig = Gig.where(doctor_id: current_doctor.id).first
    end
  end

  protected

    def configure_permitted_parameters
      # Permit needed attribute for sign_up
      # Include uid, provider for FB, GG sign up
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit({ roles: [] }, :email, :password, :password_confirmation,
             :name, :uid, :provider, :phone, :avatar,                         # similar fields
             :gender, :address, :dob,                                                # users fields
             :expertise, :description, :certificate, :verified_at)           # doctors fields
      end

      # Permit attribute for editing
      devise_parameter_sanitizer.permit(:account_update) do |user_params|
        user_params.permit({ roles: [] }, :email, :current_password, :password, :password_confirmation,
          :name, :uid, :provider, :phone,
          :title, :expertise, :certificate, :avatar, :description )
      end
    end

    # Layout
    def layout_by_resource
      if devise_controller? && resource_name == :admin
        "admin"
      else
        "application"
      end
    end

end
