class AddEventToPriceAlerts < ActiveRecord::Migration[7.2]
  def change
    add_reference :price_alerts, :event, null: false, foreign_key: true
  end
end
