class TimesTable < ActiveRecord::Base
  attr_accessible :group, :tables
  default_scope order('created_at DESC')
  self.per_page = 10
end
