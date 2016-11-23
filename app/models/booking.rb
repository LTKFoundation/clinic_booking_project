class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :gig
  belongs_to :patient
  validates :gig_id, presence: true
end
