class BookingsController < ApplicationController
  def new
  end

  def create
  end

  def update
    @booking = Booking.find_by_id params[:id]
    @booking.status = "2"
    @booking.save
  end

  def show
    @booking = Booking.find_by_id(params[:id])
    # gon.verify_code = @booking.confirm_code
  end
end