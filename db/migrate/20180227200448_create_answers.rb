class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :content
      t.references :mentor, foreign_key: true
      t.references :question, foreign_key: true
      t.boolean :solving

      t.timestamps
    end
  end
end
