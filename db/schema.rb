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

ActiveRecord::Schema.define(version: 20160728020011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachment_types", force: :cascade do |t|
    t.string   "attachment_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.integer  "resource_id"
    t.integer  "attachment_type_id"
    t.string   "url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "building_blocks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string   "world_region"
    t.string   "title"
    t.string   "author"
    t.string   "news_source"
    t.date     "date"
    t.text     "summary"
    t.string   "url"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources_building_blocks", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "resource_id"
    t.integer  "building_block_id"
    t.index ["building_block_id"], name: "index_resources_building_blocks_on_building_block_id", using: :btree
    t.index ["resource_id"], name: "index_resources_building_blocks_on_resource_id", using: :btree
  end

  create_table "resources_subtags", force: :cascade do |t|
    t.integer  "resource_id"
    t.integer  "subtag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["resource_id"], name: "index_resources_subtags_on_resource_id", using: :btree
    t.index ["subtag_id"], name: "index_resources_subtags_on_subtag_id", using: :btree
  end

  create_table "resources_tags", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "resource_id"
    t.integer  "tag_id"
    t.index ["resource_id"], name: "index_resources_tags_on_resource_id", using: :btree
    t.index ["tag_id"], name: "index_resources_tags_on_tag_id", using: :btree
  end

  create_table "subtags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "environmental_tag"
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
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
