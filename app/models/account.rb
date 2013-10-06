class Account < ActiveRecord::Base
  validates :number, presence: true
  validates :name, presence: true
  validates :credential, presence: true
end
