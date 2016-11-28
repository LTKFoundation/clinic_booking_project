class AddMandatoriesToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :name, :string, :null => false
    add_column :patients, :dob, :datetime, :null => false
    add_column :patients, :gender, :string, :null => false
    add_column :patients, :address, :string, :null => false
  end
end
