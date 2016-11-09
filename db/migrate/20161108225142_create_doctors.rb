class CreateDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :avatar
      t.string :expertise
      t.string :description
      t.string :certificate
      t.date :verified_at
      t.references :clinic, foreign_key: true

      t.timestamps
    end
  end
end
