class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy]
  before_action :authenticate_doctor!, only: [ :index, :update ]

  def index
    load_doctor
    @questions = @doctor.questions
    @unanswered_questions = @questions.not_answered_yet
    @answered_questions = @questions.answered
  end

  def create
    load_doctor
    @question = @doctor.questions.build question_params
    @question.user = current_user
    if @question.save
      flash[:success] = 'Đã đặt câu hỏi. Chúng tôi sẽ thông báo khi bạn nhận được câu trả lời.'
    else
      flash[:error] = 'Có lỗi xảy ra khi đặt câu hỏi.'
    end
    redirect_to doctor_path(@doctor)
  end

  def update
    load_question
    if @question.update question_params
      flash[:success] = 'Đã trả lời'
      redirect_back fallback_location: doctor_questions_path(current_doctor)
    else
    end
  end

  private

  def load_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :answer)
  end
end
