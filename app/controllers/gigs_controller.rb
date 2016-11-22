class GigsController < ApplicationController
	before_action :authenticate_doctor!

	def index
		@clinics = Clinic.all
		@gig = Gig.all.where(doctor_id: current_doctor.id).first
		@days = getWeekDay
		if @gig
			redirect_to doctor_gig_path(current_doctor,@gig)
		end
	end

	def create
		@gig = Gig.new
		@gig.doctor_id = current_doctor.id
		@gig.clinic_id = gigs_params[:clinic_id]
		# @gig.clinic = Clinic.find_by_name(gigs_params[:clinic_name])
		@gig.price = gigs_params[:price]
		@gig.deposit = gigs_params[:deposit]
		@gig.checkup_duration = gigs_params[:checkup_duration]
		@gig.margin_duration = 5
    if @gig.save
			@week = getWeekDay
			@week.each do |day|
				Schedule.create(:gig_id => @gig.id,:weekday => day[0],:start_at => '',:end_at => '')
			end
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
				params[:gig][:schedule].values.each do |schedule|
					@weekday = schedule[:weekday]
					@start_at = schedule[:start_at].to_s
					@end_at = schedule[:end_at].to_s
					@schedule = Schedule.find_or_initialize_by(gig_id: @gig.id,weekday: @weekday)
					if @schedule
						logger.debug @weekday+"updated"
						@schedule.start_at = @start_at
						@schedule.end_at = @end_at
						@schedule.save
					else
						Schedule.create(:gig_id => @gig.id,:weekday =>@weekday,:start_at =>@start_at,:end_at => @end_at )
						logger.debug @weekday+"created"
					end
				end
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

	def show
		@clinics = Clinic.all
		@gig = Gig.where(doctor_id: current_doctor.id).first
		# @schedules = @gig.schedules.build
		@schedules = Schedule.where(gig_id: @gig.id).order( 'weekday ASC' )
		@weekday = getWeekDay
	end

	private
	def gigs_params
		# params.require(:gig).permit(:clinic_id,:price,:deposit,:checkup_duration,:id)
		params.require(:gig).permit(:clinic_id,:price,:deposit,:checkup_duration,:id)
	end
	def getWeekDay
		@days = [["1","Thứ Hai"],
		["2","Thứ Ba"],
		["3","Thứ Tư"],
		["4","Thứ Năm"],
		["5","Thứ Sáu"],
		["6","Thứ Bảy"],
		["7","Chủ Nhật"]]
	end
end
