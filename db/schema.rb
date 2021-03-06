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

ActiveRecord::Schema.define(version: 20160415083355) do

  create_table "attachments", force: :cascade do |t|
    t.string   "attachment",  limit: 255
    t.integer  "document_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "attachments", ["document_id"], name: "index_attachments_on_document_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "control",        limit: 255
    t.integer  "office",         limit: 4
    t.datetime "date"
    t.string   "received_by",    limit: 255
    t.string   "subject",        limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "outgoing"
    t.string   "gdrive_link",    limit: 255
    t.text     "remarks",        limit: 65535
    t.datetime "letter_date"
    t.boolean  "archival"
    t.string   "action_subject", limit: 255
    t.string   "action_done",    limit: 255
    t.string   "folder",         limit: 255
    t.boolean  "completed"
    t.boolean  "fyi"
    t.boolean  "follow_up"
    t.datetime "follow_date"
    t.boolean  "urgent"
  end

  create_table "offices", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "admin"
    t.boolean  "approved"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "attachments", "documents"
end
