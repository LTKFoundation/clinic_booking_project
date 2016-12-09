class DrlocsController < ApplicationController
  before_action :authenticate_user_or_doctor

  def user_view
  end

  def index
    @uberfee = DoctorUber.find_or_create_by!(doctor_id: current_doctor.id)
    @uberfee.fee = params[:fee]
  end
end
