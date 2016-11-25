class AddTitleToDoctor < ActiveRecord::Migration[5.0]
  change_table :doctors do |t|
      t.string :title
    end
end
