class PriceAlert < ApplicationRecord
  belongs_to :user
  belongs_to :event
  default_scope -> {
    joins(:event).order("events.date")
  }
  validates :alert_price, presence: true, numericality: { only_integer: true }
end
