class CommentsController < ApplicationController
  def create
    @doctor = Doctor.find_by(id: params[:doctor_id])

    @comment = @doctor.comments.build(comment_params)
    if current_user
      @comment.user = current_user
    end

    if ! @comment.save
      render json: { error: @comment.errors.full_messages.to_sentence }, status: 422
    else
      render json: @comment
    end


  end

  def update
  end

  def destroy
  end

  private
    def comment_params
      params.require(:doctor_comment).permit(:content, :title, :rate)
    end
end
