class AddSeenAtToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :seen_at, :datetime
  end
end
