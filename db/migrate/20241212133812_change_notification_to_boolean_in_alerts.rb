class ChangeNotificationToBooleanInAlerts < ActiveRecord::Migration[7.2]
  def change
    change_column :price_alerts, :alert_user, :boolean, using: 'status::boolean'
  end
end
