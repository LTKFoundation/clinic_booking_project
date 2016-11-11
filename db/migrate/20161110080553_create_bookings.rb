class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :client, foreign_key: true, index: true
      t.references :schedule, foreign_key: true, index: true
      t.string :code,                                       null: false
      t.datetime :start_at,                                 null: false
      t.decimal :price,                                     null: false
      t.decimal :deposit,                                   null: false
      t.string :payment_status,                             null: false
      t.string :status,                                     null: false
      t.string :session_id

      t.timestamps
    end
  end
end
