class PatientsController < ApplicationController
  before_action :authenticate_user_or_doctor

  def share_info
    @patient = Patient.find_by_id(params[:patient_id])
    @patient_records = Booking.where(patient_id: params[:patient_id], user_id: current_user.id)
    @doctor = Doctor.find_by_id(params[:doctor_id])
  end

  def add_doctor
    @share = MedicRecordView.find_or_create_by!(patient_id: params[:patient_id], doctor_id: params[:doctor_id])
    if @share.persisted?
      # flash[:notice] = "Đã chia sẻ thông tin thành công"
      redirect_to patient_path(params[:patient_id])
    else
      flash[:alert] = "Đã có lỗi khi chia sẻ thông tin. Xin vui lòng thử lại sau"
      redirect_to patient_path(params[:patient_id])
    end
  end

  def remove_doctor
    @share = MedicRecordView.find(params[:id])
    @share.destroy
    if @share.persisted?
      flash[:alert] = "Đã có lỗi khi thay đổi thông tin. Xin vui lòng thử lại sau"
    end
    
    redirect_to patient_path(params[:patient_id])
  end

  def show
    @patient = Patient.find_by_id(params[:id])
    if @patient.user_id == current_user.id 
      @patient_records = Booking.where(patient_id: params[:id], user_id: current_user.id)
      @doctors = MedicRecordView.where(patient_id: params[:id])
    else
      flash[:alert] = "Bạn không có quyền xem thông tin này."
      redirect_to root_path
    end
  end

  def doctor_view
    @patient = Patient.doctor_can_view(current_doctor.id,params[:patient_id]).first
    if @patient
      @patient_records = Booking.where(patient_id: params[:patient_id])
    else
      flash[:alert] = "Bạn không có quyền xem thông tin này."
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @patients = Patient.where(user_id: current_user.id)
  end
end
