class Gig < ApplicationRecord
  belongs_to :doctor
  belongs_to :clinic

  has_many :schedules
end
