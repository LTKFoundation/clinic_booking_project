class ChangeStartAtTypeSchedule < ActiveRecord::Migration[5.0]
  def up
    change_column :schedules, :start_at, :text
		change_column :schedules, :end_at, :text
  end

  def down
    change_column :schedule, :start_at, :datetime
		change_column :schedule, :end_at, :datetime
  end
end
