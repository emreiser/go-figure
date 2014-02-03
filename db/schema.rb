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

ActiveRecord::Schema.define(version: 20140203163921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.text     "name"
    t.text     "url_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.text     "name"
    t.integer  "hdi_rank"
    t.boolean  "select"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "criteria", force: true do |t|
    t.integer  "catgories_id"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "criteria", ["catgories_id"], name: "index_criteria_on_catgories_id", using: :btree

end
