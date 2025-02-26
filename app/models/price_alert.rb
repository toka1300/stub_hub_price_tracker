class PriceAlert < ApplicationRecord
  belongs_to :user
  belongs_to :event
  default_scope -> {
    joins(:event).order("events.date")
  }
  validates :alert_price, presence: true, numericality: { only_integer: true }

  after_destroy :destroy_event_if_no_alerts

  private
    def destroy_event_if_no_alerts
      event.destroy if event.price_alerts.empty?
    end
end
