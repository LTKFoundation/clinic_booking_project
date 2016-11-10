class CreateDoctorRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :doctor_ratings do |t|
      t.references :user, foreign_key: true, index: true
      t.references :doctor, foreign_key: true, index: true
      t.references :booking, foreign_key: true, index: true
      t.integer :value

      t.timestamps
    end
  end
end
