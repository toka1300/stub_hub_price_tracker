class AddUserToPriceAlerts < ActiveRecord::Migration[7.2]
  def change
    add_reference :price_alerts, :user, null: false, foreign_key: true
    add_index :price_alerts, :user
  end
end
