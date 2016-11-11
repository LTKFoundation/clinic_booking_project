class Doctor < ApplicationRecord
  has_many :gigs
  has_many :clinics, through: :gigs

  has_one :user, as: :owner
end
