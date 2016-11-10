class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  belongs_to :booking
end
