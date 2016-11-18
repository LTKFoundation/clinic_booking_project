class HomeController < ApplicationController
  def index
    @doctors = Doctor.all
    if params[:q].present?
      @doctors = Search.doctors(params[:q])
    end
  end
end
