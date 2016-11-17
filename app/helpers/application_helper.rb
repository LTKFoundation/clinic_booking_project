module ApplicationHelper
  def no_doctors_check(doctors)
    if doctors.nil? or doctors.length == 0
      'Không tìm thấy bác sĩ nào!'
    end
  end
end
