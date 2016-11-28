class AddVerifiedAtToClinic < ActiveRecord::Migration[5.0]
  def change
    add_column :clinics, :verified_at, :datetime
  end
end
