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

ActiveRecord::Schema.define(version: 20160430110903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issues", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "body"
    t.string   "status"
    t.string   "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "subject"
    t.string   "department"
    t.integer  "staff_id"
    t.integer  "status_id"
  end

  add_index "issues", ["staff_id"], name: "index_issues_on_staff_id", using: :btree
  add_index "issues", ["status_id"], name: "index_issues_on_status_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.text     "answer"
    t.integer  "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "replies", ["issue_id"], name: "index_replies_on_issue_id", using: :btree

  create_table "staffs", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.boolean  "admin",                  default: false
  end

  add_index "staffs", ["email"], name: "index_staffs_on_email", unique: true, using: :btree
  add_index "staffs", ["reset_password_token"], name: "index_staffs_on_reset_password_token", unique: true, using: :btree
  add_index "staffs", ["username"], name: "index_staffs_on_username", unique: true, using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "issues", "staffs"
  add_foreign_key "issues", "statuses"
  add_foreign_key "replies", "issues"
end
