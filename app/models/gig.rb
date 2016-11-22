class Gig < ApplicationRecord
  belongs_to :doctor
  belongs_to :clinic

  has_many :schedules, dependent: :destroy

  def self.default_gigs
    if Doctor.all.count > 0
      Gig.create doctor: Doctor.first, clinic: Clinic.first
    end
  end
end
