class ClinicsController < ApplicationController
  # Doctor must be signed in to add a clinic
  before_action :authenticate_doctor!, only: [ :add_clinic_page ]

  # Client must be signed in to add a clinic
  before_action :authenticate_user!, only: [ :add_clinic_page_client ]

  # before_filter :require_ssl
  respond_to :html, :js, :json

  @@cur_loc = nil
  @@doctor_clinics = nil
  def index
    
    if params[:q].present? || params[:bookable].present? 
      if params[:bookable]
        @@doctor_clinics = Clinic.search_for(params[:q],true)
      else
        @@doctor_clinics = Clinic.search_for(params[:q],false)
      end
    else
      @@doctor_clinics = Clinic.all_clinic_with_gig
    end
    @all_clinic = @@doctor_clinics
    logger.debug "GET INDEX"
    respond_to do |format|
      format.html
      format.js
      format.json { render json: Clinic.search_for(params[:q]) }
    end
    gon.watch.doctor_clinics = @@doctor_clinics
    # @@doctor_clinics = DoctorClinic.clinic_around(nil)
  end

  def add_clinic_page
    gon.watch.doctor_clinics = @@doctor_clinics
    @@doctor_clinics = Clinic.clinic_around(nil)
    logger.debug "GET ADD CLINIC PAGE"
  end

  def show
    @clinic = Clinic.where(id: params[:id]).first
  end
  # def add_clinic
  #   logger.debug "adding new Clinic => Name:"+params[:name]+
  #   " Lat: "+ params[:latitude].to_s+
  #   " Lng: "+ params[:longtitude].to_s
  #   @clinic = Clinic.create!(doctor_id: params[:doctor],name: params[:name],address: params[:address],
  #   latitude: params[:latitude].to_s.to_f, longtitude: params[:longtitude].to_s.to_f)
  #   unless @clinic
  #     raise 'CAN NOT ADD CLINIC'
  #   end
  #   @clinic_near_by = Clinic.clinic_around(@@cur_loc)
  # end

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


  def create
    @clinic = Clinic.new clinic_params
    if @clinic.save
      flash[:success] = "Đã tạo phòng khám thành công"
      if doctor_signed_in? 
        redirect_to doctor_gigs_path(clinic_params[:doctor_id])
      else
        redirect_to clinics_path
      end
    else
      flash[:error] = "cant create clinic"
      if doctor_signed_in? then render add_clinic_page else render add_clinic_page_client end
    end
  end

  private

  def clinic_params
    params.require(:clinic).permit(:doctor_id, :user_id, :name, :address, :longtitude, :latitude, :photos)
  end
end
