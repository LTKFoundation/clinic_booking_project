class AddUserToPatient < ActiveRecord::Migration[5.0]
  def change
    add_reference :patients, :user, foreign_key: true
  end
end
