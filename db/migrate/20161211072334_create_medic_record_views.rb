class CreateMedicRecordViews < ActiveRecord::Migration[5.0]
  def change
    create_table :medic_record_views do |t|
      t.references :patient, foreign_key: true
      t.references :doctor, foreign_key: true

      t.timestamps
    end
  end
end
