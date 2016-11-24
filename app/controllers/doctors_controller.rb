class DoctorsController < ApplicationController
  # before_action :authenticate_doctor!
  before_action :authenticate_user_or_doctor
  # TODO
  # authorization: only the DOCTOR that's signed in can show, update, destroy
  # NO - User could view doctor details as well. They also could rate & comment

  def show

  end

  def create
  end

  def update
  end

  def destroy
  end
end
