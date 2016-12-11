class Question < ApplicationRecord
  belongs_to :doctor
  belongs_to :user

  def has_answer?
    answer.present?
  end

  def self.not_answered_yet
    where('answer IS NULL')
  end

  def self.answered
    where('answer IS NOT NULL')
  end
end
