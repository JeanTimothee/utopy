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

ActiveRecord::Schema[7.1].define(version: 2024_02_22_175817) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beds", force: :cascade do |t|
    t.integer "number"
    t.bigint "hostel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hostel_id"], name: "index_beds_on_hostel_id"
  end

  create_table "beds_bookings", force: :cascade do |t|
    t.bigint "bed_id", null: false
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bed_id"], name: "index_beds_bookings_on_bed_id"
    t.index ["booking_id"], name: "index_beds_bookings_on_booking_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "total_price_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hostel_id", null: false
    t.integer "number_of_beds"
    t.string "status", default: "pending"
    t.string "checkout_session_id"
    t.index ["hostel_id"], name: "index_bookings_on_hostel_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "phone"
    t.string "email"
    t.date "birthdate"
    t.string "country"
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["booking_id"], name: "index_contacts_on_booking_id"
  end

  create_table "hostels", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.date "opening"
    t.date "closing"
  end

  create_table "pricings", force: :cascade do |t|
    t.bigint "hostel_id", null: false
    t.integer "march"
    t.integer "april"
    t.integer "may_october"
    t.integer "june_september"
    t.integer "summer"
    t.integer "special_weekends"
    t.integer "tva"
    t.integer "sejour_tax"
    t.integer "reduction_2_6"
    t.integer "reduction_7_plus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hostel_id"], name: "index_pricings_on_hostel_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "beds", "hostels"
  add_foreign_key "beds_bookings", "beds"
  add_foreign_key "beds_bookings", "bookings"
  add_foreign_key "bookings", "hostels"
  add_foreign_key "contacts", "bookings"
  add_foreign_key "pricings", "hostels"
end
