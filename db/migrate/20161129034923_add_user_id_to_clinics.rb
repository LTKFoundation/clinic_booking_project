class AddUserIdToClinics < ActiveRecord::Migration[5.0]
  def change
    add_reference :clinics, :user, foreign_key: true
  end
end
