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

ActiveRecord::Schema.define(version: 20160924231342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "histories", force: :cascade do |t|
    t.integer  "ticket_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "event",      default: "", null: false
  end

  add_index "histories", ["ticket_id"], name: "index_histories_on_ticket_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.text     "body"
    t.integer  "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "replies", ["ticket_id"], name: "index_replies_on_ticket_id", using: :btree

  create_table "stuffs", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "stuffs", ["name"], name: "index_stuffs_on_name", unique: true, using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.string   "email",      default: "", null: false
    t.string   "subject",    default: "", null: false
    t.text     "body",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "random_id",               null: false
    t.integer  "stuff_id"
    t.integer  "department",              null: false
    t.integer  "status",     default: 0,  null: false
  end

  add_index "tickets", ["email"], name: "index_tickets_on_email", using: :btree
  add_index "tickets", ["random_id"], name: "index_tickets_on_random_id", using: :btree
  add_index "tickets", ["status"], name: "index_tickets_on_status", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
