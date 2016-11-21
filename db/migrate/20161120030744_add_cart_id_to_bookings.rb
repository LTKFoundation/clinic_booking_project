class AddCartIdToBookings < ActiveRecord::Migration[5.0]
  def change
    add_reference :bookings, :cart, foreign_key: true
  end
end
