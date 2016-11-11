class CreatePaymentMethods < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_methods do |t|
      t.string :cc_no
      t.string :ccv_no
      t.date :valid_until
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
