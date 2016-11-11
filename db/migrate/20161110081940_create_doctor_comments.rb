class CreateDoctorComments < ActiveRecord::Migration[5.0]
  def change
    create_table :doctor_comments do |t|
      t.references :doctor_rating, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.references :doctor, foreign_key: true, index: true
      t.string :content

      t.timestamps
    end
  end
end
