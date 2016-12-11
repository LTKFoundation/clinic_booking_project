class CartsController < ApplicationController
  before_action :authenticate_user!
	def create
		user_id = params[:user_id]
			@gig = Gig.find_by_id(params[:gig_id])
			cart = current_cart(user_id)
			@booking = Booking.find_or_initialize_by(user_id: user_id, cart_id: cart.id, gig_id: @gig.id)
			@booking.price =  @gig.price 
			@booking.deposit = @gig.deposit
			@booking.session_id = session[:id]
			
			# logger.debug "Before ============="
			# logger.debug params[:timeslot].to_s
			
			timeval = Time.zone.parse(params[:timeslot])
			# logger.debug "After ============="
			# logger.debug timeval.strftime("%d/%m/%Y %I:%M%p")

			@booking.start_at = timeval

			@booking.status = "0"
			if @booking.save
				redirect_to cart_path(cart.id)
			else
				flash.now[:alert] = "Không đặt được lịch khám này"
				redirect_back(fallback_location: doctor_gig_client_view_path(params[:doctor_id],params[:gig_id]))
			end 
		
	end

	def show
		@cart = Cart.where(id: params[:id],paid_at: nil).first
		if @cart
			@bookings = Booking.where(cart_id: @cart.id)
		else
			@cart = current_cart(current_user.id)
		end
	end

	def update
		@cart = Cart.find_by_id(params[:id])
		if payment_api_return?
			@cart.paid_at = Time.now
			if @cart.save
				@bookings = Booking.where(:cart_id => @cart.id, :status => "0")
				@bookings.each do |booking|
					booking.status = "1"
					booking.confirm_code = generate_confirm_code
					booking.save
				end
				flash[:notice] = "Payment Success!"
				redirect_to show_receipt_cart_path(@cart.id)
			else
				flash[:alert] = "Đã thanh toán thành công nhưng lỗi"
				redirect_back(fallback_location: cart_path(@cart.id))
			end
		else
			flash[:alert] = "Không thanh toán được!!!"
			redirect_back(fallback_location: cart_path(@cart.id))
		end
	end

	def show_receipt
		@cart = Cart.find_by_id(params[:id])
		@bookings = Booking.where(:cart_id => @cart.id,:user_id => current_user.id, :status => "1")
    @patients = Patient.where(:user_id => current_user.id)
    gon.watch.patient_list = @patients
	end

	#TODO add payment process to Stripe 
	def payment_api_return?
		true
	end
	#TODO generate true random code
	def generate_confirm_code
		code = ('A'..'Z').to_a.shuffle[0,4].join
	end

	def current_cart(user_id)
    @current_cart = Cart.find_or_create_by(user_id: user_id,paid_at: nil)
  end
end