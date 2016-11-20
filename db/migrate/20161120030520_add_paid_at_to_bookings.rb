class AddPaidAtToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :paid_at, :datetime
  end
end
