class ClientsController < ApplicationController
  # TODO
  # authorization: only the CLIENT that's signed in can show, update, destroy
	before_action :authenticate_user!
  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

	def view_gig
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
			day_english = hash_days[schedule.weekday.to_i]
			item = {"value"=>schedule.weekday,"display"=>day_vnmese[day_english]}
			# day_vnmese[hash_days[schedule.weekday].to_s]
			booking_day.push(item)
			if schedule.start_at.length > 0
				start_time = Time.parse(schedule.start_at)
				end_time = Time.parse(schedule.end_at)
				booking_time = start_time
				day_count = 0
				while booking_time < end_time do
					day_count = day_count + 1
					string_timeslot = booking_time.strftime("%I:%M%p")
					# logger.debug "Time: "+string_timeslot+"."
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

			# logger.debug str_day + ":" + str_date

			today_pos = hash_days.key(str_day)
			# logger.debug "today pos:"+today_pos.to_s
			# move today to first row
			# print_array(@booking_schedule)
			# logger.debug "++++++==========++++++==========++++++==========++++++==========++++++==========++++++=========="
			@booking_schedule = roll_array(@booking_schedule,today_pos)
			# print_array(@booking_schedule)
			# logger.debug "++++++==========++++++==========++++++==========++++++==========++++++==========++++++=========="
			fulfill_array(@booking_schedule,@max_day_count)
			# print_array(@booking_schedule)
			# logger.debug "++++++==========++++++==========++++++==========++++++==========++++++==========++++++=========="
			@booking_schedule = add_date_to_item(@booking_schedule,str_date)

			@booking_schedule = update_reserved(@booking_schedule,@gig.id)
			# logger.debug "++++++==========++++++==========++++++==========++++++==========++++++==========++++++=========="
			# print_array(@booking_schedule)
			@booking_schedule = @booking_schedule.transpose
			# print_array(@booking_schedule)

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
		booked_list = Booking.where(gig_id: gig_id).pluck(:start_at)
		booked_list.each do |booking|
			logger.debug "Booking at: "+booking.strftime("%m/%d/%Y %I:%M%p")
		end
		schedules.each do |daily_schedule|
			daily_schedule.each do |timeslot|
				check_val = timeslot["value"].to_s+" "+timeslot["display"].to_s
				if booked_list.include? check_val
					timeslot["value"] = ""
					timeslot["display"] = "booked already"
				end
			end
		end
	end

	def roll_array(array,first_pos)
		@return_arr = []
		i = 0
		while i < array.size
			@return_arr.push(array[first_pos-1])
			if(first_pos == array.size-1)
				first_pos = 0
			else
				first_pos = first_pos + 1
			end
			i = i + 1
		end
		@return_arr
	end

	def print_array(array2dim)
		i = 0
		array2dim.each do |array|
			i = i + 1
			logger.debug "array "+i.to_s
			strout = ""
			array.each do |element|
				strout = strout + element["display"].to_s + "||"
			end
			logger.debug strout
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
			"Monday" => "Thứ Hai",
			"Tuesday" => "Thứ Ba",
			"Wednesday" => "Thứ Tư",
			"Thursday" => "Thứ Năm",
			"Friday" => "Thứ Sáu",
			"Saturday" => "Thứ Bảy",
			"Sunday" => "Chủ Nhật"
		}
	end
end
