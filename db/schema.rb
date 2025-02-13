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

ActiveRecord::Schema[8.0].define(version: 2025_02_13_022906) do
  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.string "excerpt"
    t.string "feature_image"
    t.string "slug", null: false
    t.json "authors"
    t.json "tags"
    t.json "meta_data"
    t.datetime "published_at"
    t.string "ghost_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ghost_id"], name: "index_posts_on_ghost_id", unique: true
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end
end
