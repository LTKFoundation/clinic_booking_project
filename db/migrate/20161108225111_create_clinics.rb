class CreateClinics < ActiveRecord::Migration[5.0]
  def change
    create_table :clinics do |t|
      t.string :name,             null: false

      t.string :address,          null: false
      t.float :latitude
      t.float :latitude

      t.string :license
      t.string :phone
      t.string :photos
      t.string :position

      t.integer :doctor_id, index: true

      t.timestamps
    end
  end
end
