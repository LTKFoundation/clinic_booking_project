class ChangeTypeWeekday < ActiveRecord::Migration[5.0]
  def change
    remove_column :schedules, :weekday
    add_column :schedules, :weekday, :integer
  end
end
