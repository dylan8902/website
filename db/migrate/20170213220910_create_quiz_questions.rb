class CreateQuizQuestions < ActiveRecord::Migration[4.2]
  def change
    create_table :quiz_questions do |t|
      t.text :title
      t.text :correct_answer
      t.text :answer_2
      t.text :answer_3
      t.text :answer_4

      t.timestamps
    end
  end
end
