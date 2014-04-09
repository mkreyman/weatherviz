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

ActiveRecord::Schema.define(version: 20140409175740) do

  create_table "locations", force: true do |t|
    t.integer  "city_id"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "omniauth"
  end

  create_table "weather_fetchers", force: true do |t|
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
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
