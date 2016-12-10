class DrlocsController < ApplicationController
  before_action :authenticate_user_or_doctor

  def before_start
    @uberfee = DoctorUber.find_or_create_by!(doctor_id: current_doctor.id)
    @fee = 0
    if @uberfee.fee
      @fee = @uberfee.fee
    end
  end

  def index
    @uberfee = DoctorUber.find_or_create_by!(doctor_id: current_doctor.id)
    @uberfee.fee = params[:fee]
    @uberfee.save
  end

  def before_simulator
    @uberfee = DoctorUber.find_or_create_by!(doctor_id: current_doctor.id)
    @fee = 0
    if @uberfee.fee
      @fee = @uberfee.fee
    end
  end
  def simulator
    @uberfee = DoctorUber.find_or_create_by!(doctor_id: current_doctor.id)
    @uberfee.fee = params[:fee]
    @uberfee.save
  end
end
