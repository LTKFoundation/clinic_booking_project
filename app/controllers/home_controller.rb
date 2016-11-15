class HomeController < ApplicationController
  def index
    @doctors = Doctor.all
    # search query
    if params[:q].present?
      @doctors = Doctor.search(params[:q])
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
end
