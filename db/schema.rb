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

ActiveRecord::Schema.define(version: 20140128083904) do

  create_table "accounts", force: true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "credential"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "analytics", force: true do |t|
    t.text     "uri",        limit: 255
    t.string   "ip"
    t.string   "user_agent"
    t.string   "referer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "analytics", ["created_at"], name: "index_analytics_on_created_at"
  add_index "analytics", ["ip"], name: "index_analytics_on_ip"
  add_index "analytics", ["referer"], name: "index_analytics_on_referer"
  add_index "analytics", ["user_agent"], name: "index_analytics_on_user_agent"

  create_table "bank_transactions", force: true do |t|
    t.string   "description", null: false
    t.float    "amount",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bbc_twitter", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "blog_post_id"
    t.string   "name"
    t.string   "email"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_posts", force: true do |t|
    t.string   "title",      null: false
    t.text     "text",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_tags", force: true do |t|
    t.string  "tag",          null: false
    t.integer "blog_post_id", null: false
  end

  create_table "bus_stops", force: true do |t|
    t.string   "atco_code"
    t.string   "naptan_code"
    t.string   "common_name"
    t.string   "short_common_name"
    t.string   "landmark"
    t.string   "street"
    t.string   "crossing"
    t.string   "indicator"
    t.string   "bearing"
    t.string   "nptg_locality_code"
    t.string   "locality_name"
    t.string   "parent_locality_name"
    t.string   "grand_parent_locality_name"
    t.string   "town"
    t.string   "suburb"
    t.string   "lat"
    t.string   "lng"
    t.string   "stop_type"
    t.string   "bus_stop_type"
    t.string   "timing_status"
    t.string   "default_wait_time"
    t.string   "administrative_area_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bus_stops", ["naptan_code"], name: "index_bus_stops_on_naptan_code"

  create_table "dj_events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "location"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dj_tracks", force: true do |t|
    t.integer  "dj_event_id"
    t.string   "title"
    t.string   "artist"
    t.string   "artist_mbid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drops", force: true do |t|
    t.string   "uri"
    t.string   "content_type"
    t.binary   "base64"
    t.integer  "hits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", force: true do |t|
    t.string   "pid",         null: false
    t.string   "title",       null: false
    t.string   "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook_posts", force: true do |t|
    t.string   "text"
    t.string   "location"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gig_artists", force: true do |t|
    t.integer "gig_id"
    t.string  "name"
    t.string  "url"
    t.string  "mbid"
  end

  create_table "gigs", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "venue"
    t.decimal  "lat"
    t.decimal  "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iphone_locations", force: true do |t|
    t.float    "lat"
    t.float    "lng"
    t.integer  "accuracy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listens", force: true do |t|
    t.string   "artist"
    t.string   "artist_mbid"
    t.string   "track"
    t.string   "track_mbid"
    t.string   "album"
    t.string   "album_mbid"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "local_tags", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.decimal  "lat",        precision: 10, scale: 7, null: false
    t.decimal  "lng",        precision: 10, scale: 7, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["lat"], name: "index_locations_on_lat"
  add_index "locations", ["lng"], name: "index_locations_on_lng"

  create_table "mole_addons", force: true do |t|
    t.string  "name",                            null: false
    t.string  "code",                            null: false
    t.decimal "amount", precision: 10, scale: 7, null: false
  end

  create_table "mole_donations", force: true do |t|
    t.integer  "donation_id",                            null: false
    t.integer  "facebook_id"
    t.integer  "mole_addon_id"
    t.decimal  "amount",        precision: 10, scale: 7, null: false
    t.string   "source"
    t.string   "environment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mole_high_scores", force: true do |t|
    t.string   "name",        limit: 8
    t.string   "[]",          limit: 8
    t.string   "facebook_id", limit: 8
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phonecalls", force: true do |t|
    t.string   "date"
    t.string   "time"
    t.string   "contact"
    t.string   "category"
    t.string   "duration"
    t.string   "price"
    t.string   "included"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phonecalls", ["contact"], name: "index_phonecalls_on_contact"

  create_table "photos", force: true do |t|
    t.string   "title"
    t.string   "thumbnail"
    t.string   "original"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lng"
    t.text     "description"
  end

  create_table "projects", force: true do |t|
    t.string   "title",                   null: false
    t.text     "description",             null: false
    t.string   "url",                     null: false
    t.integer  "hits",        default: 0
    t.boolean  "online"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "running_events", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.decimal  "lat",                     precision: 10, scale: 7
    t.decimal  "lng",                     precision: 10, scale: 7
    t.integer  "finish_time"
    t.boolean  "training"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",    limit: 255
    t.string   "link"
    t.integer  "distance"
  end

  create_table "text_messages", force: true do |t|
    t.string   "contact",    null: false
    t.text     "text"
    t.boolean  "sent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "times_tables", force: true do |t|
    t.string   "group"
    t.string   "tables"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_categories", force: true do |t|
    t.string "code"
    t.string "name"
    t.string "description"
  end

  add_index "train_categories", ["code"], name: "index_train_categories_on_code", unique: true

  create_table "train_catering", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_catering", ["code"], name: "index_train_catering_on_code", unique: true

  create_table "train_classes", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_classes", ["code"], name: "index_train_classes_on_code", unique: true

  create_table "train_journey_legs", force: true do |t|
    t.integer  "journey_id"
    t.integer  "schedule_id"
    t.string   "departure_crs"
    t.datetime "departure_time"
    t.integer  "departure_delay"
    t.string   "departure_platform"
    t.string   "arrival_crs"
    t.datetime "arrival_time"
    t.integer  "arrival_delay"
    t.string   "arrival_platform"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "distance"
  end

  add_index "train_journey_legs", ["journey_id"], name: "index_train_journey_legs_on_journey_id"
  add_index "train_journey_legs", ["schedule_id"], name: "index_train_journey_legs_on_schedule_id"

  create_table "train_journeys", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "train_journeys", ["user_id"], name: "index_train_journeys_on_user_id"

  create_table "train_location_distances", force: true do |t|
    t.string   "origin_tiploc"
    t.string   "destination_tiploc"
    t.integer  "distance"
    t.string   "initial_direction"
    t.string   "final_direction"
    t.string   "line"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "train_location_distances", ["destination_tiploc"], name: "index_train_location_distances_on_destination_tiploc"
  add_index "train_location_distances", ["origin_tiploc"], name: "index_train_location_distances_on_origin_tiploc"

  create_table "train_locations", force: true do |t|
    t.string  "name"
    t.string  "crs"
    t.string  "nlc"
    t.string  "tiploc"
    t.string  "stanox"
    t.float   "lat"
    t.float   "lng"
    t.boolean "station"
  end

  add_index "train_locations", ["crs"], name: "index_train_locations_on_crs"
  add_index "train_locations", ["stanox"], name: "index_train_locations_on_stanox"
  add_index "train_locations", ["tiploc"], name: "index_train_locations_on_tiploc"

  create_table "train_operating_characteristics", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_operating_characteristics", ["code"], name: "index_train_operating_characteristics_on_code"

  create_table "train_operating_companies", force: true do |t|
    t.string  "name"
    t.string  "business_code"
    t.integer "numeric_code"
    t.string  "atoc"
  end

  add_index "train_operating_companies", ["atoc"], name: "index_train_operating_companies_on_atoc"

  create_table "train_platforms", force: true do |t|
    t.string   "name"
    t.string   "tiploc"
    t.integer  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "train_platforms", ["tiploc"], name: "index_train_platforms_on_tiploc"

  create_table "train_power_types", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_power_types", ["code"], name: "index_train_power_types_on_code"

  create_table "train_reservations", force: true do |t|
    t.string "code"
    t.string "name"
    t.string "symbol"
  end

  add_index "train_reservations", ["code"], name: "index_train_reservations_on_code"

  create_table "train_schedule_locations", force: true do |t|
    t.integer "schedule_id"
    t.string  "location_type"
    t.string  "record_identity"
    t.string  "tiploc_code"
    t.integer "tiploc_instance"
    t.string  "departure"
    t.string  "public_departure"
    t.string  "arrival"
    t.string  "public_arrival"
    t.string  "pass"
    t.string  "platform"
    t.string  "line"
    t.string  "engineering_allowance"
    t.string  "pathing_allowance"
    t.string  "performance_allowance"
  end

  add_index "train_schedule_locations", ["record_identity"], name: "index_train_schedule_locations_on_record_identity"
  add_index "train_schedule_locations", ["schedule_id"], name: "index_train_schedule_locations_on_schedule_id"
  add_index "train_schedule_locations", ["tiploc_code"], name: "index_train_schedule_locations_on_tiploc_code"

  create_table "train_schedules", force: true do |t|
    t.date    "schedule_start_date"
    t.date    "schedule_end_date"
    t.string  "schedule_days_runs"
    t.integer "bank_holiday_running"
    t.string  "stp_indicator"
    t.string  "train_uid"
    t.string  "applicable_timetable"
    t.string  "atoc_code"
    t.string  "signalling_id"
    t.string  "train_category"
    t.string  "headcode"
    t.string  "course_indicator"
    t.string  "train_service_code"
    t.string  "business_sector"
    t.string  "power_type_code"
    t.string  "timing_load"
    t.string  "speed"
    t.string  "operating_characteristics"
    t.string  "train_class_code"
    t.string  "sleepers"
    t.string  "reservations"
    t.string  "connection_indicator"
    t.string  "catering_code"
    t.string  "service_branding"
    t.string  "train_status"
    t.string  "ransaction_type"
  end

  add_index "train_schedules", ["headcode"], name: "index_train_schedules_on_headcode"
  add_index "train_schedules", ["schedule_end_date"], name: "index_train_schedules_on_schedule_end_date"
  add_index "train_schedules", ["schedule_start_date"], name: "index_train_schedules_on_schedule_start_date"
  add_index "train_schedules", ["train_uid"], name: "index_train_schedules_on_train_uid"

  create_table "train_statuses", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_statuses", ["code"], name: "index_train_statuses_on_code"

  create_table "train_timing_loads", force: true do |t|
    t.string "code"
    t.string "name"
  end

  add_index "train_timing_loads", ["code"], name: "index_train_timing_loads_on_code"

  create_table "tweets", force: true do |t|
    t.string   "text"
    t.string   "location"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_twitter_accounts", force: true do |t|
    t.integer "user_id"
    t.string  "screen_name"
    t.string  "oauth_token"
    t.string  "oauth_token_secret"
    t.string  "access_token"
  end

  add_index "user_twitter_accounts", ["screen_name"], name: "index_user_twitter_accounts_on_screen_name"
  add_index "user_twitter_accounts", ["user_id"], name: "index_user_twitter_accounts_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wall_scores", force: true do |t|
    t.integer  "facebook_id", limit: 8
    t.string   "name"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
