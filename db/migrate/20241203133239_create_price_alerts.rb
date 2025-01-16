class CreatePriceAlerts < ActiveRecord::Migration[7.2]
  def change
    create_table :price_alerts do |t|
      t.integer :alert_price
      t.boolean :alert_user

      t.timestamps
    end
    add_index :price_alerts, [ :user_id ]
  end
end
