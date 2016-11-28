class DoctorComment < ApplicationRecord
  belongs_to :rating
  belongs_to :user
  belongs_to :doctor

  validates :title, presence: true
  validates :content, presence: true
  validates :rate, presence: true
end
