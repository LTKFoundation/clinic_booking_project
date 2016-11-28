class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :Name
      t.datetime :DOB
      t.string :Gender
      t.string :BloodType
      t.string :Address

      t.timestamps
    end
  end
end
