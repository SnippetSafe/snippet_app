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

ActiveRecord::Schema.define(version: 2020_04_23_072513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aliases", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "language_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_aliases_on_language_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "snippet_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["snippet_id"], name: "index_comments_on_snippet_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "filenames", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "language_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_filenames_on_language_id"
  end

  create_table "folders", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "folders_snippets", id: false, force: :cascade do |t|
    t.bigint "snippet_id"
    t.bigint "folder_id"
    t.index ["folder_id"], name: "index_folders_snippets_on_folder_id"
    t.index ["snippet_id"], name: "index_folders_snippets_on_snippet_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "snippet_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["snippet_id"], name: "index_likes_on_snippet_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "mimetypes", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "language_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_mimetypes_on_language_id"
  end

  create_table "snippets", force: :cascade do |t|
    t.string "filename"
    t.string "description"
    t.text "body"
    t.boolean "public"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "language_id"
    t.bigint "user_id"
    t.integer "likes_count", default: 0
    t.integer "comments_count", default: 0
    t.index ["language_id"], name: "index_snippets_on_language_id"
    t.index ["user_id"], name: "index_snippets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "snippets"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "snippets"
  add_foreign_key "likes", "users"
end
