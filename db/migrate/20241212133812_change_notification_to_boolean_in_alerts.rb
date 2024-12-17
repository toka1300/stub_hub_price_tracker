class ChangeNotificationToBooleanInAlerts < ActiveRecord::Migration[7.2]
  def change
    change_column :price_alerts, :alert_user, :boolean, using: 'alert_user::boolean'
  end
end
