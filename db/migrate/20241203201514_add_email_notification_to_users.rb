class AddEmailNotificationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :email_notifications, :binary, default: :false
  end
end
