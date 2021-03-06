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

ActiveRecord::Schema.define(version: 20160807142143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendants", force: :cascade do |t|
    t.string   "name"
    t.string   "lastname"
    t.integer  "age"
    t.string   "gender"
    t.integer  "circle_id"
    t.integer  "wristband_id"
    t.string   "area"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "attendants", ["circle_id"], name: "index_attendants_on_circle_id", using: :btree

  create_table "circles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "event_accelerometers", force: :cascade do |t|
    t.string   "state"
    t.integer  "wristband_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "event_accelerometers", ["wristband_id"], name: "index_event_accelerometers_on_wristband_id", using: :btree

  create_table "event_bluetooths", force: :cascade do |t|
    t.string   "distance"
    t.datetime "wristband_timestamp"
    t.string   "wristband_uuid"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "friend_wristband_id"
    t.integer  "wristband_id"
  end

  create_table "event_localizations", force: :cascade do |t|
    t.float    "distance_point_a"
    t.float    "distance_point_b"
    t.float    "distance_point_c"
    t.datetime "wristband_timestamp"
    t.string   "wristband_uuid"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "wristband_id"
    t.float    "real_distance_a"
    t.float    "real_distance_b"
    t.float    "real_distance_c"
    t.float    "coord_x"
    t.float    "coord_y"
  end

  create_table "event_pulse_sensors", force: :cascade do |t|
    t.integer  "hits"
    t.string   "wristband_uuid"
    t.datetime "wristband_timestamp"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "wristband_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wristbands", force: :cascade do |t|
    t.string   "wristband_uuid"
    t.integer  "attendant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "wristbands", ["attendant_id"], name: "index_wristbands_on_attendant_id", using: :btree

  add_foreign_key "event_accelerometers", "wristbands"
  add_foreign_key "wristbands", "attendants"
end
