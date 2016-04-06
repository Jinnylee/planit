# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160406050501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accommodation_splits", force: :cascade do |t|
    t.integer  "accommodation_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "accommodations", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.datetime "check_in"
    t.datetime "check_out"
    t.string   "name"
    t.string   "location"
    t.text     "description"
    t.string   "confirmation_number"
    t.float    "price"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "link"
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "trip_id"
    t.datetime "date"
    t.datetime "time"
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.string   "link"
    t.float    "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_splits", force: :cascade do |t|
    t.integer  "expense_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.boolean  "pay_status", default: false
    t.string   "title"
    t.float    "amount"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "flight_splits", force: :cascade do |t|
    t.integer  "flight_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.datetime "departure_date"
    t.datetime "arrival_date"
    t.string   "departure_airport"
    t.string   "arrival_airport"
    t.string   "airline"
    t.string   "flight_number"
    t.string   "terminal"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "email"
    t.integer  "trip_id"
    t.string   "secure_hash"
    t.boolean  "used",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "packings", force: :cascade do |t|
    t.integer  "trip_id"
    t.string   "item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.string   "location"
    t.string   "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "activity"
    t.text     "packing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_trips", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
