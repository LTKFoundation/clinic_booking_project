class DoctorsController < ApplicationController
  # before_action :authenticate_doctor!
  # before_action :authenticate_user_or_doctor
	before_action :authenticate_doctor!, only: [:update, :destroy, :add_clinic_page]
  # TODO
  # authorization: only the DOCTOR that's signed in can show, update, destroy
  # NO - User could view doctor details as well. They also could rate & comment

  def show
    @doctor = Doctor.find(params[:id])
    @articles = Article.where(doctor_id: @doctor.id)
  end 

  def create
  end

  def update
  end

  def destroy
  end
end
