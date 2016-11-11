class Client < ApplicationRecord
  has_one :user, as: :owner
end
