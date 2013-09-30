class Account < ActiveRecord::Base
  attr_accessible :number, :name, :credential
  
  validates :number, :presence => true
  validates :name, :presence => true
  validates :credential, :presence => true
end
