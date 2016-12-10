class AddExpertiseToClinics < ActiveRecord::Migration[5.0]
  def change
    add_column :clinics, :expertise, :string
  end
end
