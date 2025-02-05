class Event < ApplicationRecord
  has_many :price_alerts, dependent: :destroy

  validates :name, presence: true
  validates :date, presence: true
  validates :venue, presence: true
  validates :live_price_cad, presence: true, numericality: { only_integer: true }
end
