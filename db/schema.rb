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

ActiveRecord::Schema.define(version: 20130927180341) do

  create_table "accounts", force: true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "credential"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bank_transactions", force: true do |t|
    t.string   "description", null: false
    t.float    "amount",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bbc_twitter", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_posts", force: true do |t|
    t.string   "title",      null: false
    t.text     "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_tags", force: true do |t|
    t.string  "tag",          null: false
    t.integer "blog_post_id", null: false
  end

  create_table "dj_events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dj_tracks", force: true do |t|
    t.integer  "dj_event_id"
    t.string   "title"
    t.string   "artist"
    t.string   "artist_mbid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "drops", force: true do |t|
    t.string   "uri"
    t.string   "content_type"
    t.binary   "base64"
    t.integer  "hits"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "episodes", force: true do |t|
    t.string   "pid",         null: false
    t.string   "title",       null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "facebook_posts", force: true do |t|
    t.string   "text"
    t.string   "location"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "iphone_locations", force: true do |t|
    t.float    "lat"
    t.float    "lng"
    t.integer  "accuracy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listens", force: true do |t|
    t.text     "artist",      null: false
    t.text     "artist_mbid", null: false
    t.text     "track",       null: false
    t.text     "track_mbid",  null: false
    t.text     "album",       null: false
    t.text     "album_mbid",  null: false
    t.text     "image",       null: false
    t.datetime "updated_at",  null: false
    t.datetime "created_at",  null: false
  end

  create_table "local_tags", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "locations", force: true do |t|
    t.integer  "latE7",      null: false
    t.integer  "lngE7",      null: false
    t.integer  "accuracy",   null: false
    t.string   "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "thumbnail"
    t.string   "original"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.integer  "hits"
    t.boolean  "online"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "text_messages", force: true do |t|
    t.string   "contact",    null: false
    t.text     "text"
    t.boolean  "sent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "text_messages", ["contact"], name: "contact", using: :btree

  create_table "times_tables", force: true do |t|
    t.string   "group"
    t.string   "tables"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "train_categories", force: true do |t|
    t.string "code"
    t.string "name"
    t.string "description"
  end

  add_index "train_categories", ["code"], name: "code", using: :btree

  create_table "train_catering", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_catering", ["code"], name: "code", using: :btree

  create_table "train_classes", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_classes", ["code"], name: "code", using: :btree

  create_table "train_journeys", force: true do |t|
    t.integer  "journey_id"
    t.string   "departure_crs"
    t.datetime "departure_time"
    t.string   "arrival_crs"
    t.datetime "arrival_time"
    t.integer  "departure_delay"
    t.integer  "arrival_delay"
    t.integer  "schedule_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
  end

  add_index "train_journeys", ["journey_id"], name: "journey_id", using: :btree
  add_index "train_journeys", ["user_id"], name: "user_id", using: :btree

  create_table "train_locations", force: true do |t|
    t.string  "name"
    t.string  "crs"
    t.string  "nlc"
    t.string  "tiploc"
    t.string  "stanox"
    t.string  "lat"
    t.string  "lng"
    t.boolean "station"
  end

  add_index "train_locations", ["crs"], name: "crs", using: :btree
  add_index "train_locations", ["name"], name: "name", using: :btree
  add_index "train_locations", ["tiploc"], name: "tiploc", using: :btree

  create_table "train_operating_characteristics", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_operating_characteristics", ["code"], name: "code", using: :btree

  create_table "train_operating_companies", force: true do |t|
    t.string  "name"
    t.string  "business_code"
    t.integer "numeric_code"
    t.string  "atoc"
  end

  add_index "train_operating_companies", ["atoc"], name: "atoc", using: :btree
  add_index "train_operating_companies", ["name"], name: "name", using: :btree

  create_table "train_power_types", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_power_types", ["code"], name: "code", using: :btree

  create_table "train_reservations", force: true do |t|
    t.string "code"
    t.string "name"
    t.string "symbol"
  end

  add_index "train_reservations", ["code"], name: "code", using: :btree

  create_table "train_schedule_locations", force: true do |t|
    t.integer "schedule_id"
    t.string  "location_type"
    t.string  "record_identity"
    t.string  "tiploc_code"
    t.integer "tiploc_instance"
    t.string  "departure"
    t.string  "public_departure",      limit: 11
    t.string  "arrival"
    t.string  "public_arrival",        limit: 11
    t.string  "pass"
    t.integer "platform"
    t.string  "line"
    t.integer "engineering_allowance"
    t.string  "pathing_allowance"
    t.integer "performance_allowance"
  end

  add_index "train_schedule_locations", ["location_type"], name: "location_type", using: :btree
  add_index "train_schedule_locations", ["schedule_id"], name: "schedule_id", using: :btree
  add_index "train_schedule_locations", ["tiploc_code"], name: "tiploc_code", using: :btree

  create_table "train_schedules", force: true do |t|
    t.integer "CIF_bank_holiday_running"
    t.string  "CIF_stp_indicator"
    t.string  "CIF_train_uid"
    t.string  "applicable_timetable"
    t.string  "atoc_code"
    t.string  "schedule_days_runs"
    t.date    "schedule_end_date"
    t.string  "signalling_id"
    t.string  "CIF_train_category"
    t.string  "CIF_headcode"
    t.integer "CIF_course_indicator"
    t.integer "CIF_train_service_code"
    t.string  "CIF_business_sector"
    t.string  "CIF_power_type"
    t.string  "CIF_timing_load"
    t.string  "CIF_speed"
    t.string  "CIF_operating_characteristics"
    t.string  "CIF_train_class"
    t.integer "CIF_sleepers"
    t.string  "CIF_reservations"
    t.integer "CIF_connection_indicator"
    t.string  "CIF_catering_code"
    t.string  "CIF_service_branding"
    t.date    "schedule_start_date"
    t.string  "train_status"
    t.string  "transaction_type"
  end

  add_index "train_schedules", ["CIF_train_uid"], name: "CIF_train_uid", using: :btree
  add_index "train_schedules", ["schedule_end_date"], name: "schedule_end_date", using: :btree
  add_index "train_schedules", ["schedule_start_date"], name: "schedule_start_date", using: :btree

  create_table "train_statuses", force: true do |t|
    t.string "code"
    t.string "name"
  end

  create_table "train_timing_loads", force: true do |t|
    t.string "code"
    t.string "name"
  end

  create_table "tweets", force: true do |t|
    t.string   "text"
    t.string   "location"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin"
    t.string   "gender"
    t.string   "city"
    t.string   "twitter"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
