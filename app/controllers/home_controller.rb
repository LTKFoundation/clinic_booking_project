class HomeController < ApplicationController
  def index
    @doctors = Doctor.paginate(:page => params[:page], :per_page => 10).order('name ASC')
    # search query
    if params[:q].present?
      @doctors = Doctor.search(params[:q]).paginate(:page => params[:page], :per_page => 10).order('name ASC')
    end

    # filter
    if params[:city].present?
      @doctors = @doctors.filter_by_city(city_params)
    end
    if params[:expertise].present?
      @doctors = @doctors.filter_by_expertise(expertise_params)
    end
    if params[:date].present? or params[:time].present?
      # binding.pry
      # Parse date and time from params to a single datetime value called expect_time
      # Today if params just contain the time
      expect_time = "#{params[:date]} #{params[:time]}".to_datetime
      # Check if each doctor is available with that expect_time
      @doctors = @doctors.map { |d| d.available?(expect_time) ? d : nil }
    end

    response do |format|
      format.html
      format.js
    end
  end

  private

  def city_params
    params.require(:city)
  end

  def search_params
    params.require(:q)
  end

  def expertise_params
    params.require(:expertise)
  end

  def datetime_params
    params.require(:date, :time)
    if params[:q].present?
      @doctors = Search.doctors(search_params)
    end

    # filter
    if params[:city].present?
      @doctors = @doctors.filter_by_city(city_params)
    end
    if params[:expertise].present?
      @doctors = @doctors.filter_by_expertise(expertise_params)
    end

    response do |format|
      format.html
      format.js
    end
  end
end
