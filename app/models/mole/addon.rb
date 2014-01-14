class Mole::Addon < ActiveRecord::Base
  self.table_name = 'mole_addons'
  validates :name, presence: true
  validates :code, presence: true
  validates :amount, presence: true

end