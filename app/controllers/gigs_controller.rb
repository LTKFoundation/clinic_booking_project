class GigsController < ApplicationController
	before_action :authenticate_doctor!

	def index
		@clinics = Clinic.all
		@gig = Gig.all.where(doctor_id: current_doctor.id).first
	end

	def create
		@gig = Gig.new
		@gig.doctor_id = current_doctor.id
		@gig.clinic_id = gigs_params[:clinic_id]
		@gig.price = gigs_params[:price]
		@gig.deposit = gigs_params[:deposit]
		@gig.checkup_duration = gigs_params[:checkup_duration]
		@gig.margin_duration = 5
    if @gig.save
			flash[:success] = "Đã thêm địa chỉ làm việc của bác sĩ"
      redirect_to doctor_gigs_path(current_doctor.id)
    else
      render 'index'
    end
	end

	def update
		@gig = Gig.find(params[:id])
		if @gig
			@gig.price = gigs_params[:price]
			@gig.deposit = gigs_params[:deposit]
			@gig.checkup_duration = gigs_params[:checkup_duration]
			if @gig.save
				flash[:success] = "Đã cập nhập thông tin thành công"
				redirect_to doctor_gigs_path(current_doctor.id)
			else
				flash[:error] = @gig.errors.full_messages.to_sentence
				redirect_to doctor_gigs_path(current_doctor.id)
			end
		else
			redirect_to doctor_gigs_path(current_doctor.id)
		end
	end
	private 
	def gigs_params
		params.require(:gig).permit(:clinic_id,:price,:deposit,:checkup_duration,:id)
	end
end
