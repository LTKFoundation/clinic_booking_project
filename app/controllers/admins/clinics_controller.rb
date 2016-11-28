class Admins::ClinicsController < Admins::AdminController
  before_action :authenticate_admin!, only: [:index, :verify]

  def index
    @clinics = Clinic.unscoped.paginate(:page => params[:page], :per_page => 10).order('verified_at DESC')
  end

  def verify
    @clinic = Clinic.find(params[:id])
    if @clinic.nil?
      flash[:error] = 'Không tìm thấy phòng khám!'
    else
      if !@clinic.verified_at.nil?
        flash[:notice] = 'Đã xác nhận phòng khám này rồi!'
      else
        @clinic.update(verified_at: DateTime.now)
        if @clinic.errors.any? then flash[:error] = 'Không thể xác nhận!' end
      end
    end

    redirect_to admins_clinics_path
  end
end
