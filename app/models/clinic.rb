class Clinic < ApplicationRecord
  has_many :gigs
  has_many :doctors, through: :gigs
	def self.clinic_around(cur_loc)
		logger.debug "Model checking current_loc"

		@return = []
		if cur_loc
			logger.debug "Received CURRENT LOC"+cur_loc[0].to_s+"||"+cur_loc[1].to_s
			@clinics = Clinic.find_by_sql ["SELECT name, latitude, longtitude FROM clinics
			WHERE earth_box(ll_to_earth( ?, ?), ?) @> ll_to_earth(latitude, longtitude)", cur_loc[0].to_s, cur_loc[1].to_s,1000]
			if @clinics
				@clinics.each do |clinic|
					@return.push([clinic.latitude,clinic.longtitude])
					logger.debug "Added: lat:"+clinic.latitude.to_s+"||"+clinic.longtitude.to_s+"to return array"
				end
			end

		else
			logger.debug "NO current_loc FOUND, load everything"
			@return = all_clinic
		end

		@return
	end

	def self.all_clinic_with_gig
		logger.debug "Querying all clinics from DB....."
		@return = []
		@clinics = Clinic.left_outer_joins(:gigs).uniq.select("clinics.*, gigs.id as gig_id, gigs.doctor_id as doctor_id")
		# @clinics = Clinic.all
		if @clinics
			@clinics.each do |clinic|
				@return.push([clinic.latitude,clinic.longtitude,clinic.name,clinic.address,clinic.id,clinic.gig_id,clinic.doctor_id])
				logger.debug "Added: lat:"+clinic.latitude.to_s+"||"+clinic.longtitude.to_s+"|clinic:"+clinic.id.to_s+"gig:"+clinic.gig_id.to_s+" to return array"
			end
		end
		@return
	end

	def self.all_clinic_with_gig
		logger.debug "Querying all clinics from DB....."
		@return = []
		@clinics = Clinic.left_outer_joins(:gigs).uniq.select("clinics.*, gigs.id as gig_id, gigs.doctor_id as doctor_id")
		# @clinics = Clinic.all
		if @clinics
			@clinics.each do |clinic|
				@return.push([clinic.latitude,clinic.longtitude,clinic.name,clinic.address,clinic.id,clinic.gig_id,clinic.doctor_id])
				logger.debug "Added: lat:"+clinic.latitude.to_s+"||"+clinic.longtitude.to_s+"|clinic:"+clinic.id.to_s+"gig:"+clinic.gig_id.to_s+" to return array"
			end
		end
		@return
	end

	def self.all_clinic
		logger.debug "Querying all clinics from DB....."
		@return = []
		@clinics = Clinic.all
		if @clinics
			@clinics.each do |clinic|
				@return.push([clinic.latitude,clinic.longtitude])
				logger.debug "Added: lat:"+clinic.latitude.to_s+"||"+clinic.longtitude.to_s+" to return array"
			end
		end
		@return
	end

  def self.default_clinics
    Clinic.create name: 'Hong ngoc', address: 'Dai La, Hai Ba Trung'
  end
end
