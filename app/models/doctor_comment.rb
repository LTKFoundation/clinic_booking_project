class DoctorComment < ApplicationRecord
  belongs_to :rating
  belongs_to :user
  belongs_to :doctor
end
