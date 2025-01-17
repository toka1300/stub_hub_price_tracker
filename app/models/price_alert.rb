class PriceAlert < ApplicationRecord
  belongs_to :user
  belongs_to :event, optional: true
  validates :alert_price, presence: true, numericality: { only_integer: true }
end
