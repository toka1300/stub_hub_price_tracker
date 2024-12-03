class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :date
      t.string :venue
      t.integer :live_price_cad
      t.string :url
      t.string :event_id
      t.string :live_price_usd

      t.timestamps
    end
  end
end
