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

ActiveRecord::Schema.define(version: 20140416222234) do

  create_table "locations", force: true do |t|
    t.integer  "city_id"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "woeid"
    t.string   "street"
    t.string   "state_code"
    t.string   "postal_code"
    t.string   "country_code"
  end

  add_index "locations", ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "omniauth"
    t.boolean  "admin",           default: false
  end

  create_table "weather_reports", force: true do |t|
    t.integer  "time_received"
    t.integer  "sunrise"
    t.integer  "sunset"
    t.string   "weather"
    t.string   "weather_desc"
    t.float    "temp"
    t.float    "temp_min"
    t.float    "temp_max"
    t.integer  "pressure"
    t.integer  "humidity"
    t.float    "wind_speed"
    t.float    "wind_gust"
    t.integer  "wind_degree"
    t.string   "clouds"
    t.integer  "rain_3h"
    t.integer  "snow_3h"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weather_reports", ["location_id"], name: "index_weather_reports_on_location_id"

end
