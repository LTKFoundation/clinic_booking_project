class AddPhotoToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :photo, :string
  end
end
