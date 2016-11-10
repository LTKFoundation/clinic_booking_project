class CreateGigs < ActiveRecord::Migration[5.0]
  def change
    create_table :gigs do |t|
      t.integer :doctor_id, index: true, foreign_key: true
      t.integer :clinic_id, index: true, foreign_key: true

      # Use decimal for Dong and $ also
      t.decimal :price, precision: 12, scale: 2
      t.decimal :deposit, precision: 12, scale: 2

      # Duration stored as minutes count
      # Access by gig.checkup_duration.minutes
      # Can do also Time.now + gig.checkup_duration.minutes
      t.integer :checkup_duration
      t.integer :margin_duration

      t.timestamps
    end
  end
end
