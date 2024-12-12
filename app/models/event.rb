class Event < ApplicationRecord
  has_many :price_alerts
  has_many :user, through: :price_alerts

  validates :name, presence: true
  validates :date, presence: true
  validates :venue, presence: true
  validates :live_price_cad, presence: true
  validates :event_type, presence: true
end
