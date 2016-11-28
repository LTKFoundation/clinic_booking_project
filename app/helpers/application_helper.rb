module ApplicationHelper
  def no_doctors_check(doctors)
    if doctors.nil? or doctors.length == 0
      'Không tìm thấy bác sĩ nào!'
    end
  end

  def no_clinics_check(clinics)
    if clinics.nil? or clinics.length == 0
      'Không tìm thấy phong kham nào!'
    end
  end
end
