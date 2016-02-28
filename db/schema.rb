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

ActiveRecord::Schema.define(version: 20160227203222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audiences", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "data_audiences", force: :cascade do |t|
    t.integer  "audience_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "datum_id"
  end

  add_index "data_audiences", ["audience_id"], name: "index_data_audiences_on_audience_id", using: :btree
  add_index "data_audiences", ["datum_id"], name: "index_data_audiences_on_datum_id", using: :btree

  create_table "point_data", force: :cascade do |t|
    t.integer  "point_id"
    t.integer  "datum_id"
    t.integer  "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "point_data", ["datum_id"], name: "index_point_data_on_datum_id", using: :btree
  add_index "point_data", ["point_id"], name: "index_point_data_on_point_id", using: :btree

  create_table "points", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "points", ["name"], name: "index_points_on_name", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tour_points", force: :cascade do |t|
    t.integer  "tour_id"
    t.integer  "point_id"
    t.integer  "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tour_points", ["point_id"], name: "index_tour_points_on_point_id", using: :btree
  add_index "tour_points", ["tour_id"], name: "index_tour_points_on_tour_id", using: :btree

  create_table "tours", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.integer  "audience_id"
  end

  add_index "tours", ["audience_id"], name: "index_tours_on_audience_id", using: :btree
  add_index "tours", ["name"], name: "index_tours_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "activated",         default: false, null: false
    t.string   "temporarypassword", default: ""
  end

end
