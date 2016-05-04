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

ActiveRecord::Schema.define(version: 20160502045216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adds", force: true do |t|
    t.string   "website"
    t.string   "url"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adds", ["property_id"], name: "index_adds_on_property_id", using: :btree

  create_table "agents", force: true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "mobile_phone"
    t.string   "other_phone"
    t.string   "password_digest"
    t.string   "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", force: true do |t|
    t.string   "type"
    t.date     "date"
    t.time     "time"
    t.string   "confirmation"
    t.string   "contact"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",              default: "agendada"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "appointments", ["property_id"], name: "index_appointments_on_property_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "neighborhoods", force: true do |t|
    t.string   "name"
    t.string   "zip_code"
    t.string   "delegacion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.string   "street"
    t.string   "number"
    t.string   "unit"
    t.string   "owned_by"
    t.integer  "user_id"
    t.integer  "neighborhood_id"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["agent_id"], name: "index_properties_on_agent_id", using: :btree
  add_index "properties", ["neighborhood_id"], name: "index_properties_on_neighborhood_id", using: :btree
  add_index "properties", ["user_id"], name: "index_properties_on_user_id", using: :btree

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "mobile_phone"
    t.string   "other_phone"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
