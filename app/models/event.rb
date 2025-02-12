require "date"

class Event < ApplicationRecord
  has_many :price_alerts, dependent: :destroy

  validates :name, presence: true
  validates :date, presence: true
  validates :venue, presence: true
  validates :live_price_cad, presence: true, numericality: { only_integer: true }
  scope :expired, -> { where("updated_at < ?", 15.minutes.ago) }
  scope :completed, -> { where("date < ?", Date.today) }
end
