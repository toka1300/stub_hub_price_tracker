# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_12_11_152223) do
  create_table "events", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "venue"
    t.integer "live_price_cad"
    t.string "url"
    t.string "event_id"
    t.integer "live_price_usd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.string "event_type"
  end

  create_table "price_alerts", force: :cascade do |t|
    t.integer "alert_price"
    t.binary "alert_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.index ["event_id"], name: "index_price_alerts_on_event_id"
    t.index ["user_id"], name: "index_price_alerts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.binary "cad", default: "true"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.binary "email_notifications", default: "false"
  end

  add_foreign_key "price_alerts", "events"
  add_foreign_key "price_alerts", "users"
end
