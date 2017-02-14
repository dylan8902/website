class Quiz::User < ApplicationRecord
  self.table_name = "quiz_users"
  validates :nickname, presence: true
  default_scope { order('points DESC') }

end
