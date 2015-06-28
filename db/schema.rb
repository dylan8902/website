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

ActiveRecord::Schema.define(version: 20150628132804) do

  create_table "accounts", force: true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "credential"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airports", force: true do |t|
    t.string  "name"
    t.string  "city"
    t.string  "country"
    t.string  "iata"
    t.string  "icao"
    t.decimal "lat",             precision: 10, scale: 7
    t.decimal "lng",             precision: 10, scale: 7
    t.integer "altitude"
    t.integer "timezone_offset"
    t.string  "dst"
  end

  create_table "analytics", force: true do |t|
    t.text     "uri"
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
    t.string   "description",            null: false
    t.float    "amount",      limit: 24, null: false
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
    t.integer  "user_id"
  end

  add_index "episodes", ["user_id"], name: "index_episodes_on_user_id"

  create_table "facebook_posts", force: true do |t|
    t.string   "text"
    t.string   "location"
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
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
    t.decimal  "lat",        precision: 10, scale: 7
    t.decimal  "lng",        precision: 10, scale: 7
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iphone_locations", force: true do |t|
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
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
    t.float    "lat",         limit: 24
    t.float    "lng",         limit: 24
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
    t.string   "name"
    t.integer  "facebook_id", limit: 8
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

  add_index "phonecalls", ["contact"], name: "index_phonecalls_on_number"

  create_table "photos", force: true do |t|
    t.string   "title"
    t.string   "thumbnail"
    t.string   "original"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat",         limit: 24
    t.float    "lng",         limit: 24
    t.text     "description"
  end

  create_table "pringles_prices", force: true do |t|
    t.string   "supermarket"
    t.string   "offer"
    t.float    "price",           limit: 24
    t.float    "price_inc_offer", limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.decimal  "lat",         precision: 10, scale: 7
    t.decimal  "lng",         precision: 10, scale: 7
    t.integer  "finish_time"
    t.boolean  "training"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "link"
    t.integer  "distance"
    t.text     "kml"
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

  create_table "trains", force: true do |t|
    t.string   "origin"
    t.string   "destination"
    t.string   "operator"
    t.decimal  "lat",         precision: 10, scale: 7
    t.decimal  "lng",         precision: 10, scale: 7
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.string   "text"
    t.string   "location"
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
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
