class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def create

    load_doctor
    @question = @doctor.questions.build question_params
    @question.user = current_user
    binding.pry
    if @question.save
      flash[:success] = 'Đã đặt câu hỏi. Chúng tôi sẽ thông báo khi bạn nhận được câu trả lời.'
    else
      flash[:error] = 'Có lỗi xảy ra khi đặt câu hỏi.'
    end
    redirect_to doctor_path(@doctor)
  end

  private

  def load_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def question_params
    params.require(:question).permit(:content)
  end
end
