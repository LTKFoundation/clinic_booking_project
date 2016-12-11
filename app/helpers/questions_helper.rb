module QuestionsHelper
  def noti_count
    if doctor_signed_in?
      current_doctor.questions.not_answered_yet.count
    else
      nil
    end
  end
end
