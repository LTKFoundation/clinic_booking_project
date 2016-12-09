class CreateDoctorUbers < ActiveRecord::Migration[5.0]
  def change
    create_table :doctor_ubers do |t|
      t.references :doctor, foreign_key: true
      t.float :fee

      t.timestamps
    end
  end
end
