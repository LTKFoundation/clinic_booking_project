class BookingsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :authenticate_doctor!
  before_action :authenticate_user_or_doctor
  def new
  end

  def create
    @gig = Gig.find_by_id(params[:gig_id])
    @patient = Patient.create(doctor_id: @gig.doctor.id, name: params[:patient_name], dob: params[:dob], gender: params[:gender], address: params[:address])
    if @patient.save
      @booking = Booking.new
      @booking.price =  @gig.price 
      @booking.deposit = @gig.deposit
      @booking.start_at = Time.zone.parse(params[:start_at])
      @booking.status = "1"
      @booking.patient_id = @patient.id
      @booking.gig_id = @gig.id
      if @booking.save
        flash.now[:success] = "Đặt thành công"
        redirect_back(fallback_location: doctor_gig_doctor_view_path(@gig.doctor.id,@gig.id))
      else
        flash.now[:error] = "Không đặt được lịch khám này"
        redirect_back(fallback_location: doctor_gig_client_view_path(@gig.doctor.id,@gig.id))
      end
    end
  end

  def show_checked
    @booking = Booking.find_by_id params[:booking_id]
    @booking.status = "2"
    @booking.save
  end

  def show
    @booking = Booking.find_by_id(params[:id])
  end
end