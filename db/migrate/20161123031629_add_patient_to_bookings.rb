class AddPatientToBookings < ActiveRecord::Migration[5.0]
  def change
    add_reference :bookings, :patient, foreign_key: true
  end
end
