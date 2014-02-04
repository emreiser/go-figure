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

ActiveRecord::Schema.define(version: 20140203224136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "country_1_id"
    t.integer  "country_2_id"
    t.integer  "criterion_id"
    t.integer  "selected_country_id"
    t.boolean  "correct"
    t.boolean  "positive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.text     "name"
    t.text     "url_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.text     "name"
    t.integer  "hdi_rank"
    t.text     "code"
    t.boolean  "select"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "criteria", force: true do |t|
    t.integer  "category_id"
    t.text     "name"
    t.boolean  "higher_good"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "criteria", ["category_id"], name: "index_criteria_on_category_id", using: :btree

  create_table "scores", force: true do |t|
    t.integer  "criterion_id"
    t.integer  "country_id"
    t.float    "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["country_id"], name: "index_scores_on_country_id", using: :btree
  add_index "scores", ["criterion_id"], name: "index_scores_on_criterion_id", using: :btree

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
