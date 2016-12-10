class Clinic < ApplicationRecord
  # Only show verified clinic to users and doctors
  # def self.default_scope
  #   where.not(verified_at: nil)
  # end

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

	def self.search_for(q,bookable)
		logger.debug "Querying all clinics from DB with name like: "+q
		@return = []
		# @clinics = Clinic.left_outer_joins(:gigs).uniq.select("clinics.*, gigs.id as gig_id, gigs.doctor_id as doctor_id")
		# @clinics = Clinic.all
    # LongV: load clinic and display gig_id of gig that has schedules set up already. Only clinic has schedules are displayed as bookable to User
    sql_string = "select clinics.latitude, clinics.longtitude, clinics.name, clinics.address, clinics.id, clinics.photos, clinics.phone, "+
    "gig_doctors.doctor_id, gig_doctors.gig_id, gig_doctors.doctor_name, clinics.expertise,gig_doctors.verified_at, gig_doctors.avatar "+
    "from clinics left outer join "+
    "(select gigs.*,doctors.name as doctor_name,doctors.expertise,doctors.verified_at,doctors.avatar  "+
    "from (select * from gigs join (select distinct gig_id from schedules) as schedules "+ 
    "on gigs.id = schedules.gig_id) as gigs  "+
    "join doctors on gigs.doctor_id = doctors.id) as gig_doctors "+
    "on clinics.id = gig_doctors.clinic_id "+
    "where upper(clinics.name) like upper('%"+q+"%') "+
    "or upper(clinics.address) like upper('%"+q+"%') "+
    "or upper(gig_doctors.doctor_name) like upper('%"+q+"%') "+
    "or upper(clinics.expertise) like upper('%"+q+"%') "+
    ";"
    @clinics = Clinic.find_by_sql sql_string 
    # raise sql_string
		if @clinics
			@clinics.each do |clinic|
        if (bookable && clinic.gig_id)||!bookable
          @return.push([clinic.latitude,clinic.longtitude,
          clinic.name,clinic.address,
          clinic.id,clinic.gig_id,
          clinic.doctor_id,clinic.photos,
          clinic.phone,clinic.doctor_name,
          clinic.expertise,clinic.avatar
          ])
        end
				# logger.debug "Added: lat:"+clinic.latitude.to_s+"||"+clinic.longtitude.to_s+"|clinic:"+clinic.id.to_s+"gig:"+clinic.gig_id.to_s+" Name:"+clinic.name+" to return array"
			end
		end
		@return
	end

	def self.all_clinic_with_gig
		logger.debug "Querying all clinics from DB....."
		@return = []
		# @clinics = Clinic.left_outer_joins(:gigs).uniq.select("clinics.*, gigs.id as gig_id, gigs.doctor_id as doctor_id")
		# @clinics = Clinic.all
    # LongV: load clinic and display gig_id of gig that has schedules set up already. Only clinic has schedules are displayed as bookable to User
    sql_string = "select clinics.latitude, clinics.longtitude, clinics.name, clinics.address, clinics.id, clinics.photos, clinics.phone, "+
    "gig_doctors.doctor_id, gig_doctors.gig_id, gig_doctors.doctor_name, clinics.expertise,gig_doctors.verified_at, gig_doctors.avatar "+
    "from clinics left outer join "+
    "(select gigs.*,doctors.name as doctor_name,doctors.expertise,doctors.verified_at,doctors.avatar  "+
    "from (select * from gigs join (select distinct gig_id from schedules) as schedules "+ 
    "on gigs.id = schedules.gig_id) as gigs  "+
    "join doctors on gigs.doctor_id = doctors.id) as gig_doctors "+
    "on clinics.id = gig_doctors.clinic_id;"
    @clinics = Clinic.find_by_sql sql_string 
    # raise sql_string
		if @clinics
			@clinics.each do |clinic|
				@return.push([clinic.latitude,clinic.longtitude,
        clinic.name,clinic.address,
        clinic.id,clinic.gig_id,
        clinic.doctor_id,clinic.photos,
        clinic.phone,clinic.doctor_name,
        clinic.expertise,clinic.avatar
        ])
				# logger.debug "Added: lat:"+clinic.latitude.to_s+"||"+clinic.longtitude.to_s+"|clinic:"+clinic.id.to_s+"gig:"+clinic.gig_id.to_s+" Name:"+clinic.name+" to return array"
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

  def photo_or_default
    photos || 'http://classroomclipart.com/images/gallery/Clipart/Architecture/medical-clinic-2-building-clipart-046.jpg'
  end

  def self.default_clinics
    Clinic.create name: 'Hong ngoc', address: 'Dai La, Hai Ba Trung'
  end
end


