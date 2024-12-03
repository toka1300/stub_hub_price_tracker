class Event < ApplicationRecord
  has_many :price_alerts
  has_many :user, through: :price_alerts
end
