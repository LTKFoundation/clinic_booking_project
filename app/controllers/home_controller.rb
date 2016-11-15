class HomeController < ApplicationController
  def index
    @doctors = Doctor.all

    # search query
    if params[:q].present?
      @doctors = Search.doctors(search_params)
    end

    # city query
    if params[:city].present?
      @doctors = Search.doctors_in_city(city_params)
      logger.debug @doctors
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
end
