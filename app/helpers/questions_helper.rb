module QuestionsHelper
  def noti_count
    if doctor_signed_in?
      current_doctor.questions.not_answered_yet.count
    else
      nil
    end
  end

  def answered_count
    if user_signed_in?
      current_user.questions.answered.not_seen.count
    end
  end

  def first_answered_path
    if answered_count > 0
      question = current_user.questions.answered.not_seen.first
      "#{ doctor_path(question.doctor) }#question-#{ current_user.questions.answered.not_seen.first.id.to_s }"
    end
  end
end
