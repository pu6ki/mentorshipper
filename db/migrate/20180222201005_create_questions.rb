class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.references :team, foreign_key: true
      t.references :technology, foreign_key: true

      t.timestamps
    end
  end
end
