class RemoveMandatoryFromPatients < ActiveRecord::Migration[5.0]
  def change
    remove_column :patients, :Name, :string
    remove_column :patients, :DOB, :string
    remove_column :patients, :Gender, :string
    remove_column :patients, :Address, :string
  end
end
