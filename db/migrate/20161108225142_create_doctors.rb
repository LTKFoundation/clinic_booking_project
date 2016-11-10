class CreateDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :doctors do |t|
      t.string :avatar
      t.string :expertise
      t.string :description
      t.string :certificate
      t.datetime :verified_at
      t.references :clinic, index:true, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
