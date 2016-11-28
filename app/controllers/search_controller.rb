class SearchController < ApplicationController
  def index
    @clinics = Clinic.all
    @clinics = @clinics.search_by_city(params[:city]) if params[:city].present?
    @clinics = @clinics.search_by_expertise(params[:expertise]) if params[:expertise].present?

    if params[:date].present? or params[:time].present?
      expect_time = "#{search_params[:date]} #{search_params[:time]}".to_datetime
      # Check if each doctor is available with that expect_time
      @clinics = @clinics.map { |c| c.available?(expect_time) ? c : nil }
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def search_params
    params.permit(:q, :city, :expertise, :date, :time)
  end
end
