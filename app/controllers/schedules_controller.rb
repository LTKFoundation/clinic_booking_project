class SchedulesController < ApplicationController

	def index
	end

	private 
	def gigs_params
		# params.require(:gig).permit(:clinic_id,:price,:deposit,:checkup_duration,:id)
	end
end
