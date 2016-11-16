class SchedulesController < ApplicationController
	before_action :authenticate_doctor!
	def index
		@gig = Gig.where(id: params[:gig_id])
		@schedule = Schedule.where(gig_id: params[:gig_id])
		@days = [["mon","Thứ Hai"],
		["tue","Thứ Ba"],
		["wed","Thứ Tư"],
		["thu","Thứ Năm"],
		["fri","Thứ Sáu"],
		["sat","Thứ Bảy"],
		["sun","Chủ Nhật"]]
		if @schedule.count>0
			redirect_to doctor_gig_schedule_path(current_user,@gig,@schedule)
		end
	end
	def show

	end
	def create
		raise 'AAA'
	end
	private 
	def schedule_params
		# params.require(:gig).permit(:clinic_id,:price,:deposit,:checkup_duration,:id)
	end
end
