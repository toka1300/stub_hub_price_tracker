class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :cad, default: true
      t.boolean :email_notification, default: false

      t.timestamps
    end
  end
end
