class RemoveColumnDateFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :date, :string
  end
end
