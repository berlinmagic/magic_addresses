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

ActiveRecord::Schema.define(version: 20151111133333) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mgca_address_translations", force: :cascade do |t|
    t.integer  "mgca_address_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "street_name"
  end

  add_index "mgca_address_translations", ["locale"], name: "index_mgca_address_translations_on_locale"
  add_index "mgca_address_translations", ["mgca_address_id"], name: "index_mgca_address_translations_on_mgca_address_id"

  create_table "mgca_addresses", force: :cascade do |t|
    t.string   "name"
    t.text     "fetch_address"
    t.string   "street_default"
    t.string   "street_number"
    t.string   "street_additional"
    t.integer  "zipcode"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "subdistrict_id"
    t.integer  "district_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "mgca_addresses", ["city_id"], name: "index_mgca_addresses_on_city_id"
  add_index "mgca_addresses", ["country_id"], name: "index_mgca_addresses_on_country_id"
  add_index "mgca_addresses", ["district_id"], name: "index_mgca_addresses_on_district_id"
  add_index "mgca_addresses", ["state_id"], name: "index_mgca_addresses_on_state_id"
  add_index "mgca_addresses", ["subdistrict_id"], name: "index_mgca_addresses_on_subdistrict_id"

  create_table "mgca_addressibles", force: :cascade do |t|
    t.boolean  "default"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mgca_addressibles", ["address_id"], name: "index_mgca_addressibles_on_address_id"
  add_index "mgca_addressibles", ["owner_type", "owner_id"], name: "index_mgca_addressibles_on_owner_type_and_owner_id"

  create_table "mgca_cities", force: :cascade do |t|
    t.string   "default_name"
    t.string   "short_name"
    t.string   "fsm_state",    default: "new"
    t.integer  "state_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgca_cities", ["country_id"], name: "index_mgca_cities_on_country_id"
  add_index "mgca_cities", ["state_id"], name: "index_mgca_cities_on_state_id"

  create_table "mgca_city_translations", force: :cascade do |t|
    t.integer  "mgca_city_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
  end

  add_index "mgca_city_translations", ["locale"], name: "index_mgca_city_translations_on_locale"
  add_index "mgca_city_translations", ["mgca_city_id"], name: "index_mgca_city_translations_on_mgca_city_id"

  create_table "mgca_countries", force: :cascade do |t|
    t.string   "default_name"
    t.string   "iso_code",     limit: 2
    t.string   "dial_code"
    t.string   "fsm_state",              default: "new"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mgca_country_translations", force: :cascade do |t|
    t.integer  "mgca_country_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
  end

  add_index "mgca_country_translations", ["locale"], name: "index_mgca_country_translations_on_locale"
  add_index "mgca_country_translations", ["mgca_country_id"], name: "index_mgca_country_translations_on_mgca_country_id"

  create_table "mgca_district_translations", force: :cascade do |t|
    t.integer  "mgca_district_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
  end

  add_index "mgca_district_translations", ["locale"], name: "index_mgca_district_translations_on_locale"
  add_index "mgca_district_translations", ["mgca_district_id"], name: "index_mgca_district_translations_on_mgca_district_id"

  create_table "mgca_districts", force: :cascade do |t|
    t.string   "default_name"
    t.string   "short_name"
    t.string   "fsm_state",    default: "new"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgca_districts", ["city_id"], name: "index_mgca_districts_on_city_id"

  create_table "mgca_state_translations", force: :cascade do |t|
    t.integer  "mgca_state_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
  end

  add_index "mgca_state_translations", ["locale"], name: "index_mgca_state_translations_on_locale"
  add_index "mgca_state_translations", ["mgca_state_id"], name: "index_mgca_state_translations_on_mgca_state_id"

  create_table "mgca_states", force: :cascade do |t|
    t.string   "default_name"
    t.string   "short_name"
    t.string   "fsm_state",    default: "new"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgca_states", ["country_id"], name: "index_mgca_states_on_country_id"

  create_table "mgca_subdistrict_translations", force: :cascade do |t|
    t.integer  "mgca_subdistrict_id", null: false
    t.string   "locale",              null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "name"
  end

  add_index "mgca_subdistrict_translations", ["locale"], name: "index_mgca_subdistrict_translations_on_locale"
  add_index "mgca_subdistrict_translations", ["mgca_subdistrict_id"], name: "index_mgca_subdistrict_translations_on_mgca_subdistrict_id"

  create_table "mgca_subdistricts", force: :cascade do |t|
    t.string   "default_name"
    t.string   "short_name"
    t.string   "fsm_state",    default: "new"
    t.integer  "district_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgca_subdistricts", ["city_id"], name: "index_mgca_subdistricts_on_city_id"
  add_index "mgca_subdistricts", ["district_id"], name: "index_mgca_subdistricts_on_district_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
