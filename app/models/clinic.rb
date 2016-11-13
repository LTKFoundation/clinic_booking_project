class Clinic < ApplicationRecord
  has_many :gigs
  has_many :doctors, through: :gigs
end
