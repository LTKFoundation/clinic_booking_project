class BookingsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :authenticate_doctor!
  before_action :authenticate_user_or_doctor
  def new
  end

  def create
    @gig = Gig.find_by_id(params[:gig_id])
    @patient = Patient.find_or_create_by!(doctor_id: @gig.doctor.id, name: params[:patient_name], dob: params[:dob], gender: params[:gender], address: params[:address])
    if @patient.persisted?
      @booking = Booking.new
      @booking.price =  @gig.price 
      @booking.deposit = @gig.deposit
      @booking.start_at = Time.zone.parse(params[:start_at])
      @booking.status = "1"
      @booking.patient_id = @patient.id
      @booking.gig_id = @gig.id
      if @booking.save
        redirect_back(fallback_location: doctor_gig_doctor_view_path(@gig.doctor.id,@gig.id))
      else
        flash[:alert] = "Không đặt được lịch khám này"
        redirect_back(fallback_location: doctor_gig_client_view_path(@gig.doctor.id,@gig.id))
      end
    end
  end

  def create_patient
    @patient = Patient.find_or_create_by!(name: params[:patient_name], dob: params[:dob], gender: params[:gender], address: params[:address])
    @patient.user_id = current_user.id
    @patient.save
    @booking = Booking.find_by_id(params[:booking_id])
    @booking.patient_id = @patient.id
    @booking.symthom = params[:symthom]
    @booking.save
    flash[:notice] = "Patient information updated"
    redirect_to booking_user_review_path(@booking.id)
  end
  
  def show_checked
    @booking = Booking.find_by_id params[:booking_id]
    @booking.status = "2"
    @booking.save
  end

  def show
    @booking = Booking.find_by_id(params[:id])
    if @patient
      @patient = Patient.doctor_can_view(current_doctor.id,@booking.patient.id).first
    end
  end

  def user_review
    @booking = Booking.find_by_id(params[:booking_id])
  end

  def add_prescription
    @booking = Booking.find_by_id(params[:booking_id])
    @booking.prescription = params[:prescription]
    @booking.save
    redirect_to booking_path(@booking.id)
  end
end