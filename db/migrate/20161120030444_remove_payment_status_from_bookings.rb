class RemovePaymentStatusFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :payment_status, :string
  end
end
