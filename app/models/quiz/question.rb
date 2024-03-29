class Quiz::Question < ApplicationRecord
  self.table_name = "quiz_questions"
  validates :title, presence: true
  scope :visible, -> { where(visible: true) }
  default_scope { order('id ASC') }

  def possible_answers
    answers = [
      correct_answer,
      answer_2,
      answer_3,
      answer_4
    ]
    return answers.shuffle
  end
end
