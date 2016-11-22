class DoctorsController < ApplicationController
	before_action :authenticate_doctor!
  # TODO
  # authorization: only the DOCTOR that's signed in can show, update, destroy

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
