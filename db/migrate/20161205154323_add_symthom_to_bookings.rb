class AddSymthomToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :symthom, :text
  end
end
