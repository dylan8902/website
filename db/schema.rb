# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_24_170402) do

  create_table "accounts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "number"
    t.string "name"
    t.string "credential"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airports", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "country"
    t.string "iata"
    t.string "icao"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
    t.integer "altitude"
    t.integer "timezone_offset"
    t.string "dst"
  end

  create_table "analytics", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "uri"
    t.string "ip"
    t.string "user_agent"
    t.string "referer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], name: "index_analytics_on_created_at"
    t.index ["ip"], name: "index_analytics_on_ip"
    t.index ["referer"], name: "index_analytics_on_referer"
    t.index ["user_agent"], name: "index_analytics_on_user_agent"
  end

  create_table "bank_transactions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description", null: false
    t.float "amount", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bbc_twitter", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.integer "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bingo_games", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.text "numbers"
    t.integer "index"
    t.text "current_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bingo_numbers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.text "instruction"
    t.text "song_name"
    t.text "song_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_comments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "blog_post_id"
    t.string "name"
    t.string "email"
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_posts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "text", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tag", null: false
    t.integer "blog_post_id", null: false
  end

  create_table "bus_stops", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "atco_code"
    t.string "naptan_code"
    t.string "common_name"
    t.string "short_common_name"
    t.string "landmark"
    t.string "street"
    t.string "crossing"
    t.string "indicator"
    t.string "bearing"
    t.string "nptg_locality_code"
    t.string "locality_name"
    t.string "parent_locality_name"
    t.string "grand_parent_locality_name"
    t.string "town"
    t.string "suburb"
    t.string "lat"
    t.string "lng"
    t.string "stop_type"
    t.string "bus_stop_type"
    t.string "timing_status"
    t.string "default_wait_time"
    t.string "administrative_area_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["naptan_code"], name: "index_bus_stops_on_naptan_code"
  end

  create_table "dj_events", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "location"
    t.string "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dj_tracks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "dj_event_id"
    t.string "title"
    t.string "artist"
    t.string "artist_mbid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drops", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "uri"
    t.string "content_type"
    t.binary "base64"
    t.integer "hits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "pid", null: false
    t.string "title", null: false
    t.string "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["user_id"], name: "index_episodes_on_user_id"
  end

  create_table "facebook_posts", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "text"
    t.string "location"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gig_artists", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "gig_id"
    t.string "name"
    t.string "url"
    t.string "mbid"
  end

  create_table "gigs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "venue"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iphone_locations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.float "lat"
    t.float "lng"
    t.integer "accuracy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listens", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "artist"
    t.string "artist_mbid"
    t.string "track"
    t.string "track_mbid"
    t.string "album"
    t.string "album_mbid"
    t.string "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "local_tags", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_id"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "lat", precision: 10, scale: 7, null: false
    t.decimal "lng", precision: 10, scale: 7, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["lat"], name: "index_locations_on_lat"
    t.index ["lng"], name: "index_locations_on_lng"
  end

  create_table "mole_addons", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.decimal "amount", precision: 10, scale: 7, null: false
  end

  create_table "mole_donations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "donation_id", null: false
    t.integer "facebook_id"
    t.integer "mole_addon_id"
    t.decimal "amount", precision: 10, scale: 7, null: false
    t.string "source"
    t.string "environment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mole_high_scores", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "facebook_id"
    t.integer "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monzo_transactions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "monzo_id"
    t.text "description", size: :medium
    t.integer "amount"
    t.string "currency"
    t.text "merchant", size: :medium
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "json"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
  end

  create_table "oauth_clients", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.text "name"
    t.text "client_id"
    t.text "client_secret"
    t.text "access_token"
    t.text "refresh_token"
    t.text "expires_at"
    t.text "scope"
    t.text "response_type"
    t.text "redirect_uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phonecalls", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "date"
    t.string "time"
    t.string "contact"
    t.string "category"
    t.string "duration"
    t.string "price"
    t.string "included"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["contact"], name: "index_phonecalls_on_contact"
  end

  create_table "photos", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "thumbnail"
    t.string "original"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "lat"
    t.float "lng"
    t.text "description"
  end

  create_table "pringles_prices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "supermarket"
    t.string "offer"
    t.float "price"
    t.float "price_inc_offer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.string "url", null: false
    t.integer "hits", default: 0
    t.boolean "online"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_questions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "title"
    t.text "correct_answer"
    t.text "answer_2"
    t.text "answer_3"
    t.text "answer_4"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "visible", default: false
  end

  create_table "quiz_users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "nickname"
    t.integer "points", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "time"
    t.text "title"
    t.text "summary"
    t.text "url"
    t.text "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "running_events", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
    t.integer "finish_time"
    t.boolean "training"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position"
    t.string "link"
    t.integer "distance"
    t.text "kml", size: :medium
    t.string "strava_id"
  end

  create_table "security_vulnerabilities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "domain"
    t.string "url"
    t.boolean "fixed"
    t.text "summary"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "reported_at"
    t.datetime "fixed_at"
    t.boolean "wont_fix", default: false
  end

  create_table "solar_readings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.date "date"
    t.float "kwh"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "text_messages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "contact", null: false
    t.text "text"
    t.boolean "sent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "times_tables", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "group"
    t.string "tables"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trains", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "origin"
    t.string "destination"
    t.string "operator"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", id: :bigint, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "text"
    t.string "location"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_twitter_accounts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "screen_name"
    t.string "oauth_token"
    t.string "oauth_token_secret"
    t.string "access_token"
    t.index ["screen_name"], name: "index_user_twitter_accounts_on_screen_name"
    t.index ["user_id"], name: "index_user_twitter_accounts_on_user_id"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wall_scores", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "facebook_id"
    t.string "name"
    t.integer "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wedding_rsvps", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.boolean "rsvp"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "dietary_requirements"
  end

end
