class ClinicsController < ApplicationController
	@@cur_loc = nil
	@@doctor_clinics = nil
	def index
		gon.watch.doctor_clinics = @@doctor_clinics
		logger.debug "GET INDEX"
		# @@doctor_clinics = DoctorClinic.clinic_around(nil)
	end

	def create
		# gon.doctor_clinics = @@doctor_clinics
		logger.debug "POST TO CREATE"
		# @@doctor_clinics = DoctorClinic.clinic_around(nil)
	end

	def add_clinic
		logger.debug "adding new Clinic => Name:"+params[:name]+
		" Lat: "+ params[:latitude].to_s+
		" Lng: "+ params[:longtitude].to_s
		@clinic = Clinic.create!(doctor_id: params[:doctor],name: params[:name],address: params[:address], 
		latitude: params[:latitude].to_s.to_f, longtitude: params[:longtitude].to_s.to_f)
		unless @clinic
			raise 'CAN NOT ADD CLINIC'
		end
		@clinic_near_by = Clinic.clinic_around(@@cur_loc)
	end

	def clinic_near_by
		logger.debug "Loading Clinics near Loc: "+@@cur_loc[0].to_s+"||"+@@cur_loc[1].to_s
		@clinic_near_by = Clinic.clinic_around(@@cur_loc)
	end

	def current_loc
		logger.debug "Receiving Current Loc"+params[:latitude].to_s+"||"+params[:longtitude].to_s
		@@cur_loc = [params[:latitude], params[:longtitude]] 
		logger.info "Current Log Received"+@@cur_loc[0].to_s+"||"+@@cur_loc[1].to_s
		@@doctor_clinics = clinic_near_by
	end

	def sort_nearest
		@@cur_loc = [params[:latitude], params[:longtitude]]
		@@doctor_clinics = Clinic.find_by_sql ["SELECT name, latitude, longtitude, earth_distance(ll_to_earth( ?, ? ), 
		ll_to_earth(clinics.latitude, clinics.longtitude)) as distance_from_current_location 
		FROM clinics ORDER BY distance_from_current_location ASC", @@cur_loc[0].to_s.to_f, @@cur_loc[1].to_s.to_f]
	end
end
