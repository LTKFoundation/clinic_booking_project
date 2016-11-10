class Clinic < ApplicationRecord
  belongs_to :owner, class_name: 'Doctor'

  has_many :gigs
  has_many :doctors, through: :gigs
end
