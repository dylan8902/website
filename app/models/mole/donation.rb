class Mole::Donation < ApplicationRecord
  self.table_name = 'mole_donations'
  validates :donation_id, presence: true
  validates :amount, presence: true
  has_one :mole_addon

end
