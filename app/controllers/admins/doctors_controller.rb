class Admins::DoctorsController < Admins::AdminController
  before_action :authenticate_admin!

  def index
    @doctors = Doctor.paginate(:page => params[:page], :per_page => 10).order('verified_at DESC')
  end

  def verify
    @doctor = Doctor.find_by_id(params[:id])
    if (!@doctor)
      flash[:alert] = "Doctor not found!"
    else
      if @doctor.verified?
        flash[:alert] = "Doctor verified already!"
      else
        @doctor.verified_at = Time.now
        @doctor.save
        flash[:notice] = "Doctor verified successfully!"
      end
    end
    redirect_to admins_doctors_path
  end

end
