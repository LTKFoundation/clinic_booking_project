class Question < ApplicationRecord
  belongs_to :doctor
  belongs_to :user

  def has_answer?
    answer.present?
  end
end
