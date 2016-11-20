class RemoveScheduleIdFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :schedule_id, :string
  end
end
