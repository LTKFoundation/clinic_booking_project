class RemoveCodeFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :code, :string
  end
end
