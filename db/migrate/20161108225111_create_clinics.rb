class CreateClinics < ActiveRecord::Migration[5.0]
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :photos
      t.string :address
      t.string :position

      t.timestamps
    end
  end
end
