class AddPrescriptionToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :prescription, :text
  end
end
