class PriceAlert < ApplicationRecord
  belongs_to :user
  # belongs_to :event
  validates :user_id, presence: true
  validates :alert_price, presence: true, numericality: { only_integer: true }
end
