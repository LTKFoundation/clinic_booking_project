class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.integer :session_id
      t.integer :user_id
      t.datetime :paid_at
      t.integer :grand_total

      t.timestamps
    end
    add_index :carts, :user_id
  end
end
