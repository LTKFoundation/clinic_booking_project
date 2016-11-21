class AddGigIdToBookings < ActiveRecord::Migration[5.0]
  def change
    add_reference :bookings, :gig, foreign_key: true
  end
end
