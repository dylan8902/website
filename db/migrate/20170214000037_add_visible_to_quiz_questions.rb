class AddVisibleToQuizQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :quiz_questions, :visible, :boolean, :default => false
  end
end
