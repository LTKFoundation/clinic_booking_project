class AddLongtitudeToClinics < ActiveRecord::Migration[5.0]
  def change
    add_column :clinics, :longtitude, :float
  end
end
