class Phonecall < ActiveRecord::Base
  validates :number, presence: true

  default_scope { order('created_at DESC') }

end
