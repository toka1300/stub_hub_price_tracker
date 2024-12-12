class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.string :venue
      t.integer :live_price_cad
      t.string :url
      t.string :event_id
      t.integer :live_price_usd
      t.string :event_type
      t.string :image_url

      t.timestamps
    end
  end
end
