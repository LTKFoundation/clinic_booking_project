class RemovePaidAtFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :paid_at, :string
  end
end
