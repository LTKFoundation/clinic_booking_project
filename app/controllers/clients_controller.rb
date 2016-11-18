class ClientsController < ApplicationController
  # TODO
  # authorization: only the CLIENT that's signed in can show, update, destroy

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
		@schedules.each do |schedule|
			booking_day = []
			booking_day.push(schedule.weekday)
			if schedule.start_at.length > 0
				# logger.debug "Day: "+schedule.weekday+" Start:"+schedule.start_at+" End: "+schedule.end_at+" Dur:"+each_dur.to_s+"================="
				start_time = Time.parse(schedule.start_at)
				end_time = Time.parse(schedule.end_at)
				booking_time = start_time
				day_count = 0
				while booking_time < end_time do
					day_count = day_count + 1
					string_timeslot = booking_time.strftime("%I:%M%p")
					# logger.debug "Time: "+string_timeslot+"."
					booking_day.push(string_timeslot)
					booking_time = booking_time + each_dur*60
				end 
				if @max_day_count < day_count
					@max_day_count = day_count
				end
			end
			@booking_schedule.push(booking_day)
		end
			# print_array(@booking_schedule)
			# logger.debug "++++++==========++++++==========++++++==========++++++==========++++++==========++++++=========="
			fulfill_array(@booking_schedule,@max_day_count)
			# print_array(@booking_schedule)
			# logger.debug "++++++==========++++++==========++++++==========++++++==========++++++==========++++++=========="
			@booking_schedule = @booking_schedule.transpose
			# print_array(@booking_schedule)
	end

	def fulfill_array(array2dim,max)
		array2dim.each do |array|
			while array.size <= max
				array.push("")
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
				strout = strout + element.to_s + "||"
			end
			# logger.debug strout
		end
	end

end
