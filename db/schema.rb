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

ActiveRecord::Schema.define(version: 20140622192749) do

  create_table "companies", force: true do |t|
    t.integer  "parent_company_id"
    t.integer  "company_type_id"
    t.integer  "state_id"
    t.string   "name"
    t.string   "additional_name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "city"
    t.string   "zip"
    t.string   "url"
    t.string   "naic_code"
    t.string   "ai_carrier_code"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_frequencies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.string   "name"
    t.text     "notes"
    t.string   "stage_feed_url"
    t.string   "production_feed_url"
    t.datetime "production_start_date"
    t.datetime "production_end_date"
    t.integer  "company_id"
    t.integer  "feed_status_id"
    t.integer  "feed_frequency_id"
    t.integer  "feed_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parent_companies", force: true do |t|
    t.string   "name"
    t.string   "additional_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parent_companies", ["additional_name"], name: "index_parent_companies_on_additional_name", unique: true
  add_index "parent_companies", ["name"], name: "index_parent_companies_on_name", unique: true

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
