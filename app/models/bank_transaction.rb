class BankTransaction < ActiveRecord::Base
  attr_accessible :description, :amount
  
  validates :description, :presence => true
  validates :amount, :presence => true

  default_scope order('created_at DESC')
  
  def balance
    balance = BankTransaction.where("created_at <= ?", created_at).sum(:amount).round(2)
    ActionController::Base.helpers.number_to_currency(balance, :unit => "&pound;") 
  end
  
end
