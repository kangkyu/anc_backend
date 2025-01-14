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

ActiveRecord::Schema[7.1].define(version: 2024_10_21_181419) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channel_videos", force: :cascade do |t|
    t.string "youtube_id", null: false
    t.string "title", null: false
    t.string "thumbnail_url", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prayers", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "counter", default: 0, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_prayers_on_user_id"
  end

  create_table "prayings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "prayer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prayer_id", "user_id"], name: "index_prayings_on_prayer_id_and_user_id", unique: true
    t.index ["prayer_id"], name: "index_prayings_on_prayer_id"
    t.index ["user_id"], name: "index_prayings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firebase_user", null: false
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "prayers", "users"
  add_foreign_key "prayings", "prayers"
  add_foreign_key "prayings", "users"
end
