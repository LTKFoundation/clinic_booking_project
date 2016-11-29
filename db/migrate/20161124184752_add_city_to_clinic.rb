class AddCityToClinic < ActiveRecord::Migration[5.0]
  def change
        add_reference :clinics, :city, foreign_key: true
  end
end
