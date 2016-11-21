class AddConfirmCodeToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :confirm_code, :string
  end
end
