class AddRateAndTitleToDoctorComment < ActiveRecord::Migration[5.0]
  change_table :doctor_comments do |t|
    t.integer :rate
    t.string :title
  end
end
