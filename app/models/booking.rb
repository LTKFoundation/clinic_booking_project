class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :gig
  belongs_to :patient
  # has_one :patient
  validates :gig_id, presence: true
end
