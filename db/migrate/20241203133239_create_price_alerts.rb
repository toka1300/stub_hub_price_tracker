class CreatePriceAlerts < ActiveRecord::Migration[7.2]
  def change
    create_table :price_alerts do |t|
      t.integer :alert_price
      t.binary :alert_user

      t.timestamps
    end
  end
end
