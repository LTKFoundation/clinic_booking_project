class AddDateToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :date, :datetime, null: false 
  end
end
