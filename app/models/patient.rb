class Patient < ApplicationRecord
  # def create
  #   @patient = Patient.find_or_create_by!(name: params[:patient_name], dob: params[:dob], gender: params[:gender], address: params[:address])
  #   @patient.user_id = current_user.id
  #   @patient.save
  #   @booking = Booking.find_by_id(params[:booking_id])
  #   @booking.patient_id = @patient.id
  #   @booking.save
  #   flash[:success] = "Đã thêm thông tin người được khám"
  #   render 'show_receipt'
  # end
  # belongs_to :booking

  def gender_title
    if gender == "1"
      gender = "Nữ"
    else
      gender = "Nam"
    end
    gender
  end

  def age
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

end
