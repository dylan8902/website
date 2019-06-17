class SolarReading < ApplicationRecord
  validates :date, presence: true, uniqueness: true
  validates :kwh, presence: true
  default_scope { order(date: :desc) }

  def self.total
    "%.2f kWh".html_safe % SolarReading.sum(:kwh)
  end

end
