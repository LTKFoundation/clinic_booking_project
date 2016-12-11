class GigsController < ApplicationController
	before_action :authenticate_doctor!

	def index
		@clinics = Clinic.all
		@gig = Gig.all.where(doctor_id: current_doctor.id).first
		@weekdays = getWeekDayArray
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
			@week = getWeekDayArray
			@week.each do |day|
				Schedule.create(:gig_id => @gig.id,:weekday => day[0],:start_at => '',:end_at => '')
			end

			flash[:notice] = "Đã thêm địa chỉ làm việc của bác sĩ"
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
					@weekday = schedule[:weekday].to_s
					@start_at = schedule[:start_at].to_s
					@end_at = schedule[:end_at].to_s
					@schedule = Schedule.find_or_initialize_by(gig_id: @gig.id,weekday: @weekday)
					if @schedule
						# logger.debug @weekday+"updated"
						@schedule.start_at = @start_at
						@schedule.end_at = @end_at
						@schedule.save
					else
						Schedule.create(:gig_id => @gig.id,:weekday =>@weekday,:start_at =>@start_at,:end_at => @end_at )
						# logger.debug @weekday+"created"
					end
				end
				flash[:notice] = "Đã cập nhập thông tin thành công"
				redirect_to doctor_gigs_path(current_doctor.id)
			else
				flash[:alert] = @gig.errors.full_messages.to_sentence
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
		@weekday = dayInVnmese
	end

	def booking_manage
		@doctor = Doctor.where(id: params[:doctor_id])
		@gig = Gig.where(id: params[:gig_id]).first
		each_dur = @gig.checkup_duration
		@schedules = Schedule.where(gig_id: @gig.id).order( 'weekday ASC' )
		@booking_schedule = []
		@max_day_count = 0
		day_vnmese = dayInVnmese
		hash_days = getWeekDay
		current_date = Date.today
		str_day = current_date.strftime("%A")
		str_date = current_date.strftime("%d/%m/%Y")

		@schedules.each do |schedule|
			booking_day = []
			item = {"value"=>schedule.weekday,"display"=>day_vnmese[schedule.weekday.to_i]}
			booking_day.push(item)
			if schedule.start_at.length > 0

				start_time = Time.parse(schedule.start_at)
				end_time = Time.parse(schedule.end_at)
				booking_time = start_time
				day_count = 0
				while booking_time < end_time do
					day_count = day_count + 1
					string_timeslot = booking_time.strftime("%I:%M%p")
					item = {"value"=>"","display"=>string_timeslot}
					booking_day.push(item)
					booking_time = booking_time + each_dur*60
				end
				if @max_day_count < day_count
					@max_day_count = day_count
				end
			end
			@booking_schedule.push(booking_day)
		end
    today_pos = hash_days.key(str_day)
    @booking_schedule = roll_array(@booking_schedule,today_pos)
    fulfill_array(@booking_schedule,@max_day_count)
    @booking_schedule = add_date_to_item(@booking_schedule,str_date)
    @booking_schedule = update_reserved(@booking_schedule,@gig.id)
    @booking_schedule = @booking_schedule.transpose
	end

	def add_date_to_item(array2dim,today_date)
		current_date = today_date
		array2dim.each do |array|
			i = 0
			while i < array.size
				if i == 0
					array[i] = {"value"=>array[i]["value"],"display"=>array[i]["display"] + " "+current_date}
				else
					strTime = array[i]["display"]
					array[i] = {"value"=>current_date,"display"=>strTime}
				end
				i = i + 1
			end
			current_date = (Date.parse(current_date)+1).strftime("%d/%m/%Y").to_s
		end
	end

	def fulfill_array(array2dim,max)
		array2dim.each do |array|
			while array.size <= max
				array.push({"value"=>"","display"=>""})
			end
		end
	end

	def roll_array(array,first_pos)
		@return_arr = []
		i = 0
		while i < array.size
			@return_arr.push(array[first_pos-1])
			if(first_pos == array.size)
				first_pos = 1
			else
				first_pos = first_pos + 1
			end
			i = i + 1
		end
		@return_arr
	end

	def update_reserved(schedules,gig_id)
		booked_list = Booking.where(gig_id: gig_id).where.not(status: "0")
		# booked_list.each do |booking|
		# 	logger.debug "Booking at: "+booking.strftime("%m/%d/%Y %I:%M%p")
		# end
		schedules.each do |daily_schedule|
			daily_schedule.each do |timeslot|
        if timeslot["display"].length > 0
          check_val = timeslot["value"].to_s+" "+timeslot["display"].to_s
          booked_list.each do |booking|
            # logger.debug "Checking "+booking.start_at.strftime("%d/%m/%Y %I:%M%p")+" against "+check_val
            if booking.start_at.strftime("%d/%m/%Y %I:%M%p") == check_val
              timeslot["value"] = "id:"+booking.id.to_s
              if booking.patient
                timeslot["display"] = booking.patient.name
              else
                timeslot["display"] = booking.user.name
              end
              # logger.debug "=====>Matched on "+booking.start_at.strftime("%m/%d/%Y %I:%M%p")+" for "+booking.user.name
            end
          end
        end
			end
		end
	end

	def print_array(array2dim)
		i = 0
		array2dim.each do |array|
			i = i + 1
			# logger.debug "array "+i.to_s
			strout = ""
			array.each do |element|
				strout = strout + element["display"].to_s + "||"
			end
			# logger.debug strout
		end
	end

	def getWeekDay
		@days = {
			1 => "Monday",
			2 => "Tuesday",
			3 => "Wednesday",
			4 => "Thursday",
			5 => "Friday",
			6 => "Saturday",
			7 => "Sunday"
		}
	end

	def dayInVnmese
		@days = {
			1 => "Thứ Hai",
			2 => "Thứ Ba",
			3 => "Thứ Tư",
			4 => "Thứ Năm",
			5 => "Thứ Sáu",
			6 => "Thứ Bảy",
			7 => "Chủ Nhật"
		}
	end

	private
	def gigs_params
		params.require(:gig).permit(:clinic_id,:price,:deposit,:checkup_duration,:id)
	end
	def getWeekDayArray
		@days = [["1","Thứ Hai"],
		["2","Thứ Ba"],
		["3","Thứ Tư"],
		["4","Thứ Năm"],
		["5","Thứ Sáu"],
		["6","Thứ Bảy"],
		["7","Chủ Nhật"]]
	end

end
