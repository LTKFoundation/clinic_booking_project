class CreateDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :expertise,            null: false
      t.string :description
      t.string :certificate
      t.datetime :verified_at

      t.timestamps
    end
  end
end
