class CreateDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :certificate
      t.string :avatar
      t.string :status,                       null: false, default: "Not verified"
      t.string :expertise
      t.string :description
      t.references :clinic, foreign_key: true

      t.timestamps
    end
  end
end
