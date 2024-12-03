class User < ApplicationRecord
  has_many :price_alerts
  has_many :events, through: :price_alerts
end
