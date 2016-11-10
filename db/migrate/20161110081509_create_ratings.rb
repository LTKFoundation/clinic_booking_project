class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.references :doctor, foreign_key: true
      t.references :booking, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
