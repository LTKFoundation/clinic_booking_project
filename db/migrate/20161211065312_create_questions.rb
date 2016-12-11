class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :doctor, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.text :content,                                     null: false
      t.text :answer

      t.timestamps
    end
  end
end
